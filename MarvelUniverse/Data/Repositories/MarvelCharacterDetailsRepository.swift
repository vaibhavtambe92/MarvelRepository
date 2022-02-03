//
//  MarvelCharacterDetailsRepository.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 25/01/22.
//

import Foundation

final class MarvelCharacterDetailsRepository {
    typealias CharacterDetailsResult = Result<MarvelCharacterResponseDTO, DataTransferError>
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension MarvelCharacterDetailsRepository: MarvelCharacterDetailsRepositoryProtocol {

    func fetchMarvelCharacter(characterId: Int,
                              completion: @escaping (Result<MarvelCharacterDetails, Error>) -> Void) -> Cancellable? {
        let apiRequest = APIRequestProvider.getMarvelCharacter(with: characterId)

        let task = RepositoryTask()

        task.networkTask = dataTransferService.request(with: apiRequest,
                                                       completion: { (result: CharacterDetailsResult) in
                                                        switch result {
                                                        case .success(let response):
                                                            let marvelResponse = response.toDomainDetail()
                                                            let characters = marvelResponse.marvelCharacters
                                                            guard let marvelCharacter = characters.first else {
                                                                let dataError = DataTransferError.noResponse
                                                                completion(.failure(dataError))
                                                                return
                                                            }
                                                            completion(.success(marvelCharacter))
                                                        case .failure(let error):
                                                            completion(.failure(error))
                                                        }
                                                       })
        return task
    }
}

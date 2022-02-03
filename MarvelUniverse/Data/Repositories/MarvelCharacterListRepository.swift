//
//  MarvelCharacterListRepository.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 22/01/22.
//

import Foundation

final class MarvelCharacterListRepository {
    typealias CharacterListResult = Result<MarvelCharacterResponseDTO, DataTransferError>
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension MarvelCharacterListRepository: MarvelCharacterListRepositoryProtocol {
    func fetchMarvelList(page: Int,
                         completion: @escaping (Result<MarvelCharacterPage, Error>) -> Void) -> Cancellable? {
        let requestDTO = MarvelCharacterRequestDTO(limit: MarvelConstant.CharacterListPageLimit.limit,
                                                   offset: page)
        let apiRequest = APIRequestProvider.getMarvelCharacterList(with: requestDTO)
        let task = RepositoryTask()

        task.networkTask = dataTransferService.request(with: apiRequest,
                                                       completion: { (result: CharacterListResult) in
                                                        switch result {
                                                        case .success(let response):
                                                            completion(.success(response.toDomain()))
                                                        case .failure(let error):
                                                            completion(.failure(error))
                                                        }
                                                       })
        return task
    }
}

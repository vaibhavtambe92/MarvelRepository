//
//  MarvelCharacterDetailsUseCase.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 25/01/22.
//

import Foundation

final class MarvelCharacterDetailsUseCase: MarvelCharacterDetailsUseCaseProtocol {

    private let marvelCharacterDetailsRepository: MarvelCharacterDetailsRepositoryProtocol

    init(marvelCharacterDetailsRepository: MarvelCharacterDetailsRepositoryProtocol) {
        self.marvelCharacterDetailsRepository = marvelCharacterDetailsRepository
    }

    func executeMarvelCharacter(characterId: Int,
                                completion: @escaping (Result<MarvelCharacterDetails, Error>) -> Void) -> Cancellable? {
        marvelCharacterDetailsRepository.fetchMarvelCharacter(characterId: characterId,
                                                              completion: completion)
    }
}

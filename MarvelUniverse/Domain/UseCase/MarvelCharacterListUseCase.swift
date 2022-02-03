//
//  MarvelCharacterUseCase.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 21/01/22.
//

import Foundation

final class MarvelCharacterListUseCase: MarvelCharacterListUseCaseProtocol {

    private let marvelCharacterRepository: MarvelCharacterListRepositoryProtocol

    init(marvelCharacterRepository: MarvelCharacterListRepositoryProtocol) {
        self.marvelCharacterRepository = marvelCharacterRepository
    }

    func executeMarvelList(page: Int,
                           completion: @escaping (Result<MarvelCharacterPage, Error>) -> Void) -> Cancellable? {
        marvelCharacterRepository.fetchMarvelList(page: page,
                                                  completion: completion)
    }
}

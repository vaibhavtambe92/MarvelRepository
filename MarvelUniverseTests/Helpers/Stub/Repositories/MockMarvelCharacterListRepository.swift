//
//  MockMarvelCharacterListRepository.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import Foundation
@testable import MarvelUniverse

struct MockMarvelCharacterListRepository: MarvelCharacterListRepositoryProtocol {
    var result: Result<MarvelCharacterPage, Error>

    func fetchMarvelList(page: Int,
                         completion: @escaping (Result<MarvelCharacterPage, Error>) -> Void) -> Cancellable? {
        completion(result)
        return nil
    }
}

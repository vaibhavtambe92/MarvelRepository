//
//  MockMarvelCharacterDetailsRepository.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import Foundation
@testable import MarvelUniverse

struct MockMarvelCharacterDetailsRepository: MarvelCharacterDetailsRepositoryProtocol {
    var detailsResult: Result<MarvelCharacterDetails, Error>

    func fetchMarvelCharacter(characterId: Int,
                              completion: @escaping (Result<MarvelCharacterDetails, Error>) -> Void) -> Cancellable? {
        completion(detailsResult)
        return nil
    }
}

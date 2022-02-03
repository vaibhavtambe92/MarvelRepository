//
//  MockMarvelCharacterDetailsUseCase.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 27/01/22.
//

import Foundation
@testable import MarvelUniverse

struct MockMarvelCharacterDetailsUseCase: MarvelCharacterDetailsUseCaseProtocol {

    var result: Result<MarvelCharacterDetails, Error>

    func executeMarvelCharacter(characterId: Int,
                                completion: @escaping (Result<MarvelCharacterDetails, Error>) -> Void) -> Cancellable? {
        let response = (try? result.get())!
        completion(.success(response))
        return nil
    }
}

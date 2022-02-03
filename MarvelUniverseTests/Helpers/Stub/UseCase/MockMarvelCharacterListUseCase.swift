//
//  MockMarvelCharacterListUseCase.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 27/01/22.
//

import Foundation
@testable import MarvelUniverse

struct MockMarvelCharacterListUseCase: MarvelCharacterListUseCaseProtocol {
    var result: Result<MarvelCharacterPage, Error>

    func executeMarvelList(page: Int,
                           completion: @escaping (Result<MarvelCharacterPage, Error>) -> Void) -> Cancellable? {
        let response = (try? result.get())!
        completion(.success(response))
        return nil
    }
}

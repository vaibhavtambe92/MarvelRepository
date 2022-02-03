//
//  APIRequestProviderTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
@testable import MarvelUniverse

class APIRequestProviderTests: XCTestCase {

    func testGetMarvelCharacterList() {
        let apiRequest = APIRequestProvider.getMarvelCharacterList(with: MarvelCharacterRequestDTO(limit: 0, offset: 0))
        XCTAssertNil(apiRequest.path)
        XCTAssertEqual(apiRequest.method, .get)
    }

    func testGetMarvelCharacterRequest() {
        let apiRequest = APIRequestProvider.getMarvelCharacter(with: 1)
        XCTAssertEqual(apiRequest.path, "/\(1)")
        XCTAssertEqual(apiRequest.method, .get)
    }
}

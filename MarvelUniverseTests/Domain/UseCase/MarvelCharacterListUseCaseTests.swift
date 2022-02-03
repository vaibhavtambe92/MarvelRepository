//
//  MarvelCharacterListUseCase.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
@testable import MarvelUniverse

class MarvelCharacterListUseCaseTest: XCTestCase {

    var marvelCharacterListUseCase: MarvelCharacterListUseCase!

    override func setUpWithError() throws {
        let result = MockDataProvider.marvelPage[0]
        let characterListRepository = MockMarvelCharacterListRepository(result: .success(result))
        marvelCharacterListUseCase = MarvelCharacterListUseCase(marvelCharacterRepository: characterListRepository)
    }

    override func tearDownWithError() throws {
        marvelCharacterListUseCase = nil
    }

    func testMarvelCharacterListUseCase() {
        // given
        let expectation = self.expectation(description: "Marvel character list")

        // when
        var response = MockDataProvider.marvelPage[1]
        _ = marvelCharacterListUseCase.executeMarvelList(page: 0, completion: { result in
            response = (try? result.get())!
            expectation.fulfill()
        })

        // then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(response.marvelCharacters.contains(MockDataProvider.marvelPage[0].marvelCharacters[0]))
    }

}

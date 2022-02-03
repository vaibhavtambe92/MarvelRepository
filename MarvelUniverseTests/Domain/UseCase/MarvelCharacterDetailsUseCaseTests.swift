//
//  MarvelCharacterDetailsUseCaseTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
@testable import MarvelUniverse

class MarvelCharacterDetailsUseCaseTests: XCTestCase {

    var marvelCharacterDetailsUseCase: MarvelCharacterDetailsUseCaseProtocol!

    override func setUpWithError() throws {
        let result = MockDataProvider.marvelDetails
        let marvelCharacterDetailsRepository = MockMarvelCharacterDetailsRepository(detailsResult:
                                                                                        .success(result))
        marvelCharacterDetailsUseCase = MarvelCharacterDetailsUseCase(marvelCharacterDetailsRepository:
                                                                        marvelCharacterDetailsRepository)
    }

    override func tearDownWithError() throws {
        marvelCharacterDetailsUseCase = nil
    }

    func testMarvelCharacterDetailsUseCase() {
        // given
        let expectation = self.expectation(description: "Marvel character details")

        // when
        var response = MockDataProvider.marvelDetails
        _ = marvelCharacterDetailsUseCase.executeMarvelCharacter(characterId: 1, completion: { result in
            response = (try? result.get())!
            expectation.fulfill()
        })

        // then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(MockDataProvider.marvelDetails, response)

    }
}

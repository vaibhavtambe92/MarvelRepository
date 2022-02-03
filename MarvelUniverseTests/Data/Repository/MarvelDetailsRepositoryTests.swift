//
//  MarvelDetailsRepositoryTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
@testable import MarvelUniverse

class MarvelDetailsRepositoryTests: XCTestCase {

    var marvelDetailsRepository: MarvelCharacterDetailsRepositoryProtocol!

    override func setUpWithError() throws {
        let result = MockDataProvider.marvelListDTO
        marvelDetailsRepository = MarvelCharacterDetailsRepository(dataTransferService:
                                                                    MockDataTransferService(result: .success(result)))
    }

    override func tearDownWithError() throws {
        marvelDetailsRepository = nil
    }

    func testMarvelListRepository() throws {
        // given
        let expectation = self.expectation(description: "Marvel list repository test")

        // when
        var response = MockDataProvider.marvelDetails
        _ = marvelDetailsRepository.fetchMarvelCharacter(characterId: 1, completion: { result in
            response = (try? result.get())!
            expectation.fulfill()
        })

        // then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(MockDataProvider.marvelDetails, response)
    }

}

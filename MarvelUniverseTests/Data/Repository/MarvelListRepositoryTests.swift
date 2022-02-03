//
//  MarvelListRepositoryTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
@testable import MarvelUniverse

class MarvelListRepositoryTests: XCTestCase {

    var marvelListRepository: MarvelCharacterListRepositoryProtocol!

    override func setUpWithError() throws {
        let result = MockDataProvider.marvelListDTO
        marvelListRepository = MarvelCharacterListRepository(dataTransferService:
                                                                MockDataTransferService(result: .success(result)))
    }

    override func tearDownWithError() throws {
        marvelListRepository = nil
    }

    func testMarvelListRepository() throws {
        // given
        let expectation = self.expectation(description: "Marvel list repository test")

        // when
        var response = MockDataProvider.marvelPage[1]
        _ = marvelListRepository.fetchMarvelList(page: 0, completion: { result in
            response = (try? result.get())!
            expectation.fulfill()
        })

        // then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(response.marvelCharacters.contains(MockDataProvider.marvelPage[0].marvelCharacters[0]))
    }

}

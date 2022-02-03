//
//  DataTransferServiceTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
@testable import MarvelUniverse

class DataTransferServiceTests: XCTestCase {

    var dataTransferService: DataTransferService!

    override func setUpWithError() throws {
        let result = MockModel(name: "abc")
        dataTransferService = DefaultDataTransferService(with:
                                                            MockNetworkService(result: .success(result)))
    }

    override func tearDownWithError() throws {
        dataTransferService = nil
    }

    func testRequestWithDecodableResult() throws {
        // given
        let expectation = self.expectation(description: "Request with decodable result")

        // when
        var response = MockModel(name: "dummy")
        let request = APIRequestProvider.getMarvelCharacter(with: 1)
        _ = dataTransferService.request(with: request, completion: { (result: Result<MockModel, DataTransferError>) in
            response = (try? result.get())!
            expectation.fulfill()
        })

        // then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(MockModel(name: "abc"), response)
    }

}

struct MockModel: Decodable, Equatable {
    let name: String
}

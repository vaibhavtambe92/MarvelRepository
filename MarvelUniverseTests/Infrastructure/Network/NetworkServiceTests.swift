//
//  NetworkServiceTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import XCTest
import Alamofire
@testable import MarvelUniverse

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService!
    var baseUrl: URL!
    var error: AFError!

    override func setUpWithError() throws {
        baseUrl = URL(string: "www.google.com")
        error = AFError.explicitlyCancelled
        let result = MockModel(name: "abc")
        networkService = DefaultNetworkService(networkconfiguration: ApiDataNetworkConfiguration(baseURL: baseUrl),
                                               sessionManager: MockNetworkSessionManager(result: .success(result)),
                                               logger: MockNetworkErrorLogger())
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testRequestWithDecodableResult() throws {
        // given
        let expectation = self.expectation(description: "Request with decodable result")

        // when
        var response = MockModel(name: "dummy")
        let request = APIRequestProvider.getMarvelCharacter(with: 1)
        _ = networkService.request(apiRequest: request, completion: { (result: Result<MockModel?, NetworkError>) in
            response = (try? result.get())!
            expectation.fulfill()
        })

        // then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(MockModel(name: "abc"), response)
    }

    func testRequestDecodableResult_whenFailure() {
        let expectation = self.expectation(description: "Should return hasStatusCode error")

        networkService = DefaultNetworkService(networkconfiguration: ApiDataNetworkConfiguration(baseURL: baseUrl!),
                                               sessionManager: MockNetworkSessionManager(result: .failure(error)),
                                               logger: MockNetworkErrorLogger())

        let request = APIRequestProvider.getMarvelCharacter(with: 1)
        _ = networkService.request(apiRequest: request, completion: { (result: Result<MockModel?, NetworkError>) in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case NetworkError.generic(AFError.explicitlyCancelled) = error {
                    expectation.fulfill()
                }
            }
        })

        // then
        wait(for: [expectation], timeout: 1)
    }

}

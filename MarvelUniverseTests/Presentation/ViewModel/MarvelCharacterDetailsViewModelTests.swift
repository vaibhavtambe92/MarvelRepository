//
//  MarvelCharacterDetailsViewModelTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 27/01/22.
//

import XCTest
@testable import MarvelUniverse

class MarvelCharacterDetailsViewModelTests: XCTestCase {

    var viewModel: MarvelCharacterDetailsViewModelProtocol!

    override func setUpWithError() throws {
        let result = MockDataProvider.marvelDetails
        viewModel = MarvelCharacterDetailsViewModel(characterId: 1,
                                                    marvelCharacterDetailsUseCase:
                                                        MockMarvelCharacterDetailsUseCase(result: .success(result)))
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetMarvelCharacter() {

        // when
        XCTAssertNil(viewModel.marvelCharacter.value)
        viewModel.getMarvelCharacter()

        // then
        XCTAssertNotNil(viewModel.marvelCharacter.value)
        XCTAssertEqual(viewModel.marvelCharacter.value!, MockDataProvider.marvelDetails)
    }

}

//
//  MarvelCharacterListViewModelTests.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 27/01/22.
//

import XCTest
@testable import MarvelUniverse

class MarvelCharacterListViewModelTests: XCTestCase {

    var viewModel: CharacterListViewModelProtocol!
    var isShowCharacterDetailsCalled: Bool = false

    override func setUpWithError() throws {
        let result = MockDataProvider.marvelPage[0]
        viewModel = CharacterListViewModel(marvelCharactersUseCase:
                                            MockMarvelCharacterListUseCase(result:
                                                                            .success(result)),
                                           actions:
                                            MarvelCharacterListViewModelActions(showMarvelCharacterDetails:
                                                                                    showCharacterDetails(characterId:)))
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    private func showCharacterDetails(characterId: Int) {
        isShowCharacterDetailsCalled = true
    }

    func testDidLoadNextPage() {
        // when
        viewModel.didLoadNextPage()

        // then
        XCTAssertFalse(viewModel.characters.value.isEmpty)
    }

    func testDidSelectCharacter() {
        // when
        viewModel.didLoadNextPage()
        viewModel.didSelectItem(character: viewModel.characters.value[0])

        // then
        XCTAssertTrue(isShowCharacterDetailsCalled)
    }

}

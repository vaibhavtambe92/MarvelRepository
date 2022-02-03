//
//  MarvelUniverseDIContainer.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit

final class MarvelUniverseDIContainer {

    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Repositories
    private func makeMarvelCharacterListRepository() -> MarvelCharacterListRepositoryProtocol {
        return MarvelCharacterListRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    private func makeMarvelCharacterDetailsRepository() -> MarvelCharacterDetailsRepositoryProtocol {
        return MarvelCharacterDetailsRepository(dataTransferService: dependencies.apiDataTransferService)
    }

    // MARK: - UseCase
    private func makeMarvelCharacterListUseCase() -> MarvelCharacterListUseCaseProtocol {
        return MarvelCharacterListUseCase(marvelCharacterRepository: makeMarvelCharacterListRepository())
    }

    private func makeMarvelCharacterDetailsUseCase() -> MarvelCharacterDetailsUseCaseProtocol {
        return MarvelCharacterDetailsUseCase(marvelCharacterDetailsRepository: makeMarvelCharacterDetailsRepository())
    }

    // MARK: - Marvel Character List
    func makeCharacterListViewController(actions: MarvelCharacterListViewModelActions) -> CharacterListViewController {
        return CharacterListViewController.create(with: makeCharacterListViewModel(actions: actions))
    }

    private func makeCharacterListViewModel(actions: MarvelCharacterListViewModelActions) -> CharacterListViewModel {
        return CharacterListViewModel(marvelCharactersUseCase: makeMarvelCharacterListUseCase(), actions: actions)
    }

    // MARK: - Marvel Character Details
    func makeCharacterDetailsViewController(characterId: Int) -> MarvelCharacterDetailsViewController {
        return MarvelCharacterDetailsViewController.create(with: makeMarvelCharacterDetailsViewModel(characterId:
                                                                                                        characterId))
    }

    private func makeMarvelCharacterDetailsViewModel(characterId: Int) -> MarvelCharacterDetailsViewModelProtocol {
        return MarvelCharacterDetailsViewModel(characterId: characterId,
                                               marvelCharacterDetailsUseCase: makeMarvelCharacterDetailsUseCase())
    }

    // MARK: - Flow Coordinators
    func makeMarvelUniverseFlowCoordinator(navigationController: UINavigationController)
    -> MarvelUniverseFlowCoordinator {
        return MarvelUniverseFlowCoordinator(navigationController: navigationController,
                                             dependencies: self)
    }
}

extension MarvelUniverseDIContainer: MarvelUniverseFlowCoordinatorDependancies {}

//
//  MarvelUniverseFlowCoordinator.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit

protocol MarvelUniverseFlowCoordinatorDependancies {
    func makeCharacterListViewController(actions: MarvelCharacterListViewModelActions) -> CharacterListViewController
    func makeCharacterDetailsViewController(characterId: Int) -> MarvelCharacterDetailsViewController
}

final class MarvelUniverseFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: MarvelUniverseFlowCoordinatorDependancies

    init(navigationController: UINavigationController,
         dependencies: MarvelUniverseFlowCoordinatorDependancies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = MarvelCharacterListViewModelActions(showMarvelCharacterDetails:
                                                            showCharacterDetails(characterId:))
        let viewController = dependencies.makeCharacterListViewController(actions:
                                                                actions)

        navigationController?.pushViewController(viewController, animated: false)
    }

    private func showCharacterDetails(characterId: Int) {
        let marvelCharacterDetailsViewController = dependencies.makeCharacterDetailsViewController(characterId:
                                                                                                    characterId)
        navigationController?.pushViewController(marvelCharacterDetailsViewController,
                                                 animated: true)
    }
}

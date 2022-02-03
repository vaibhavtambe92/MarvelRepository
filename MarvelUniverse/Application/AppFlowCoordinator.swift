//
//  AppFlowCoordinator.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit

final class AppFlowCoordinator {

    private var navigationController: UINavigationController
    private let appContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appContainer = appDIContainer
    }

    func start() {
        let marvelUniverseDIContainer = appContainer.makeMarvelUniverseDIContainer()
        let flow = marvelUniverseDIContainer.makeMarvelUniverseFlowCoordinator(navigationController:
                                                                                navigationController)
        flow.start()
    }
}

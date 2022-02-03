//
//  AppDIContainer.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation

final class AppDIContainer {

    lazy private var appConfiguration = AppConfiguration()
    lazy private var queryParameterProvider = APIParameterProvider()

    // MARK: - Network
    lazy private var apiDataTransferService: DataTransferService = {
        let headers = [MUHTTPHeaders.accept.rawValue:
                        MUHTTPHeadersValues.acceptValue.rawValue]
        let queryParameters = queryParameterProvider.evaluateQueryParameters(for:
                                                                                appConfiguration)
        let apiDataNetworkConfiguration = ApiDataNetworkConfiguration(baseURL: URL(string: appConfiguration.apiBaseURL),
                                                                      headers: headers,
                                                                      queryParameters: queryParameters)

        let apiDataNetwork = DefaultNetworkService(networkconfiguration: apiDataNetworkConfiguration)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    // MARK: - DIContainers of scenes
    func makeMarvelUniverseDIContainer() -> MarvelUniverseDIContainer {
        let dependencies = MarvelUniverseDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return MarvelUniverseDIContainer(dependencies: dependencies)
    }
}

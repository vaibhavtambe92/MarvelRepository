//
//  AppConfiguration.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("APIKey not found in plist")
        }
        return apiKey
    }()
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "APIBaseURL") as? String else {
            fatalError("APIBaseURL not found in plist")
        }
        return apiBaseURL
    }()
    lazy var privateKey: String = {
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "APIPrivateKey") as? String else {
            fatalError("APIPrivateKey not found in plist")
        }
        return privateKey
    }()
}

//
//  NetworkConfiguration.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL? { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct ApiDataNetworkConfiguration: NetworkConfigurable {
    let baseURL: URL?
    let headers: [String: String]
    let queryParameters: [String: String]

    init(baseURL: URL?,
         headers: [String: String] = [:],
         queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}

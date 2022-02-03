//
//  APIRequest.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 21/01/22.
//

import Foundation
import Alamofire

 protocol Requestable {
    var path: String? { get }
    var isFullPath: Bool { get }
    var method: HTTPMethod { get }
    var headerParamaters: [String: String] { get }
    var parametersEncodable: Encodable? { get }
    var parameters: [String: Any] { get }
    var bodyEncoding: ParameterEncoder { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> DataRequest
}

enum RequestCreationError: Error {
    case invalidUrl
    case badString
}

class APIRequest: Requestable {

     let path: String?
     let isFullPath: Bool
     let method: HTTPMethod
     let headerParamaters: [String: String]
     let parametersEncodable: Encodable?
     let parameters: [String: Any]
     let bodyEncoding: ParameterEncoder

    init(path: String? = nil,
         isFullPath: Bool = false,
         method: HTTPMethod,
         headerParamaters: [String: String] = [:],
         parametersEncodable: Encodable? = nil,
         parameters: [String: Any] = [:],
         bodyEncoding: ParameterEncoder = JSONParameterEncoder.default) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParamaters = headerParamaters
        self.parametersEncodable = parametersEncodable
        self.parameters = parameters
        self.bodyEncoding = bodyEncoding
    }
}

extension Requestable {

    private func url(with configuration: NetworkConfigurable) throws -> URL {
        guard let baseUrl = configuration.baseURL else { throw RequestCreationError.invalidUrl }
        var urlString: String
        if let basePath = path {
            let baseUrlString = baseUrl.absoluteString
            let baseURL = baseUrlString.last != "/" && !basePath.isEmpty ? baseUrlString + "/" : baseUrlString
            urlString = isFullPath ? basePath : baseURL.appending(basePath)
        } else {
            urlString = baseUrl.absoluteString
        }

        guard let url = URL(string: urlString) else { throw RequestCreationError.badString }
        return url
    }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> DataRequest {
        let url = try self.url(with: networkConfig)
        var allHeaders: [String: String] = networkConfig.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
        let headers = allHeaders.toHeader()
        let queryParameters = try parametersEncodable?.toDictionary() ?? parameters
        let finalQueryParameters = queryParameters.merging(networkConfig.queryParameters) { (current, _) in current }
        return AF.request(url,
                          method: method,
                          parameters: finalQueryParameters,
                          headers: headers)
    }
}

private extension Dictionary where Key == String, Value == String {
    func toHeader() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        for (key, value) in self {
            headers.add(name: key, value: value)
        }
        return headers
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}

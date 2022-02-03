//
//  APIParameterProvider.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 24/01/22.
//

import Foundation
import CryptoKit

enum MUHTTPHeaders: String {
    case accept = "Accept"
}

enum MUHTTPHeadersValues: String {
    case acceptValue = "*/*"
}

final class APIParameterProvider {

    func evaluateQueryParameters(for appConfiguration: AppConfiguration) -> [String: String] {

        let timeStamp = Date().stringValue()
        let hash = getHash(timeStamp: timeStamp, appConfiguration: appConfiguration)

        var queryParameterDictionary = [String: String]()
        queryParameterDictionary["apikey"] = appConfiguration.apiKey
        queryParameterDictionary["hash"] = hash
        queryParameterDictionary["ts"] = timeStamp
        return queryParameterDictionary
    }

    private func getHash(timeStamp: String, appConfiguration: AppConfiguration) -> String {
        let hashString = timeStamp+"\(appConfiguration.privateKey)"+"\(appConfiguration.apiKey)"
        let digest = Insecure.MD5.hash(data: hashString.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

}

private extension Date {
    func stringValue() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSSSS'Z'"
        return dateFormatter.string(from: self)
    }
}

//
//  MockNetworkService.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//
import Foundation
import Alamofire
@testable import MarvelUniverse

struct MockNetworkService: NetworkService {

    var result: Result<Decodable, Error>

    func request<T>(apiRequest: Requestable,
                    completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where T: Decodable {
        do {
            guard let data = try result.get() as? T else {
                throw NetworkError.cancelled
            }
            completion(.success(data))
        } catch _ {
            completion(.failure(NetworkError.cancelled))
        }
        return nil
    }
}

struct MockNetworkSessionManager: NetworkSessionManager {

    var result: Result<Decodable, Error>

    func request<T>(_ request: DataRequest,
                    completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where T: Decodable {
        do {
            guard let data = try result.get() as? T else {
                throw AFError.explicitlyCancelled
            }
            completion(.success(data))
        } catch _ {
            completion(.failure(AFError.explicitlyCancelled))
        }
        return nil
    }
}

struct MockNetworkErrorLogger: NetworkErrorLogger {
    func log(request: URLRequest) {}

    func log(responseData data: Decodable?) {}

    func log(error: Error) {}
}

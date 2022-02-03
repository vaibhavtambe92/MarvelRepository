//
//  NetworkService.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case error(statusCode: Int)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

protocol NetworkCancellable {
    @discardableResult func cancel() -> Self
}

extension Request: NetworkCancellable { }

protocol NetworkService {
    typealias CompletionHandler<T: Decodable> = (Result<T?, NetworkError>) -> Void

    func request<T: Decodable>(apiRequest: Requestable,
                               completion: @escaping CompletionHandler<T>) -> NetworkCancellable?
}

protocol NetworkSessionManager {
    typealias CompletionHandler<T> = (Result<T, AFError>) -> Void

    func request<T: Decodable>(_ request: DataRequest,
                               completion: @escaping CompletionHandler<T>) -> NetworkCancellable?
}

protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Decodable?)
    func log(error: Error)
}

// MARK: - Implementation
final class DefaultNetworkService {

    private let networkconfiguration: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    private let logger: NetworkErrorLogger

    init(networkconfiguration: NetworkConfigurable,
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
         logger: NetworkErrorLogger = DefaultNetworkErrorLogger()) {
        self.sessionManager = sessionManager
        self.networkconfiguration = networkconfiguration
        self.logger = logger
    }

    private func request<T: Decodable>(request: DataRequest,
                                       completion: @escaping CompletionHandler<T>) -> NetworkCancellable? {

        let sessionDataTask = sessionManager.request(request) { [weak self] (response: Result<T, AFError>) in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.logger.log(responseData: data)
                completion(.success(data))

            case .failure(let error):
                var networkError: NetworkError
                if let errorCode = error.responseCode {
                    networkError = .error(statusCode: errorCode)
                } else {
                    networkError = self.resolve(error: error)
                }

                self.logger.log(error: networkError)
                completion(.failure(networkError))
            }
        }

        return sessionDataTask
    }

    private func resolve(error: AFError) -> NetworkError {
        if let urlError = error.underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet: return .notConnected
            case .cancelled: return .cancelled
            default: return .generic(error)
            }
        } else {
            return .generic(error)
        }
    }
}

extension DefaultNetworkService: NetworkService {

    func request<T: Decodable>(apiRequest: Requestable,
                               completion: @escaping CompletionHandler<T>) -> NetworkCancellable? {
        do {
            let urlRequest = try apiRequest.urlRequest(with: networkconfiguration)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }

}

// MARK: - Default Network Session Manager
class DefaultNetworkSessionManager: NetworkSessionManager {
    init() {}
    func request<T: Decodable>(_ request: DataRequest,
                               completion: @escaping CompletionHandler<T>) -> NetworkCancellable? {
        request.responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
}

// MARK: - Logger
final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    init() { }

    func log(request: URLRequest) {
        print("-------------")
        print("request: \(request.url!)")
        print("headers: \(request.allHTTPHeaderFields!)")
        print("method: \(request.httpMethod!)")
        if let httpBody = request.httpBody,
           let jsonObject = (try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]),
           let result = (jsonObject as [String: AnyObject]??) {
            printIfDebug("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("body: \(String(describing: resultString))")
        }
    }

    func log(responseData data: Decodable?) {
        guard let data = data else { return }
        printIfDebug("responseData: \(data)")
    }

    func log(error: Error) {
        printIfDebug("\(error)")
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}

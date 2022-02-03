//
//  DataTransferService.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation
import Alamofire

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferService {
    typealias CompletionHandler<T: Decodable> = (Result<T, DataTransferError>) -> Void

    @discardableResult
    func request<T: Decodable, R: Requestable>(with request: R,
                                               completion: @escaping CompletionHandler<T>) -> NetworkCancellable?
}

protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

protocol DataTransferErrorLogger {
    func log(error: Error)
}

final class DefaultDataTransferService {

    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger

    init(with networkService: NetworkService,
         errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(),
         errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferService {

    func request<T: Decodable, R: Requestable>(with apiRequest: R,
                                               completion: @escaping CompletionHandler<T>) -> NetworkCancellable? {

        return networkService.request(apiRequest: apiRequest) { (result: Result<T?, NetworkError>) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return completion(.failure(.noResponse))
                }
                return completion(.success(data))
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                return completion(.failure(error))
            }
        }
    }

    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}

// MARK: - Logger
final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    init() { }

    func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}

// MARK: - Error Resolver
class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    init() { }
    func resolve(error: NetworkError) -> Error {
        return error
    }
}

extension DataTransferError: ConnectionError {
    var isInternetConnectionError: Bool {
        guard case let DataTransferError.networkFailure(networkError) = self,
              case .notConnected = networkError else {
            return false
        }
        return true
    }
}

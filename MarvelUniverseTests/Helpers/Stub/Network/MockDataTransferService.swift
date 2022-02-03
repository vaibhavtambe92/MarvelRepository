//
//  MockDataTransferService.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import Foundation
@testable import MarvelUniverse

struct MockDataTransferService: DataTransferService {

    var result: Result<Decodable, Error>

    func request<T, R>(with request: R,
                       completion: @escaping CompletionHandler<T>)
    -> NetworkCancellable? where T: Decodable, R: Requestable {
        do {
            guard let data = try result.get() as? T else {
                throw DataTransferError.noResponse
            }
            completion(.success(data))
        } catch _ {
            completion(.failure( DataTransferError.noResponse))
        }
        return nil
    }
}

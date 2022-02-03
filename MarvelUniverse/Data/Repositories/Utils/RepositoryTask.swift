//
//  RepositoryTask.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 22/01/22.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    private var isCancelled: Bool = false

    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}

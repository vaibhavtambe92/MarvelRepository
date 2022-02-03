//
//  Observable.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 22/01/22.
//

import Foundation

final class Observable<Value> {
    private var closure: ((Value) -> Void)?

    var value: Value {
        didSet { closure?(value) }
    }

    init(_ value: Value) {
        self.value = value
    }

    func observe(_ closure: @escaping (Value) -> Void) {
        self.closure = closure
        closure(value)
    }
}

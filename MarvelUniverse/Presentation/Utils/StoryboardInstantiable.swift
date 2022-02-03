//
//  StoryboardInstantiable.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype ViewController
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> ViewController
}

extension StoryboardInstantiable where Self: UIViewController {

    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyBoard = UIStoryboard(name: "Main", bundle: bundle)
        guard let viewController = storyBoard.instantiateViewController(identifier: fileName) as? Self else {
            fatalError(" view controller creation error")
        }
        return viewController
    }
}

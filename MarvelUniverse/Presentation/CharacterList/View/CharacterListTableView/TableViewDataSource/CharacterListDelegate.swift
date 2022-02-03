//
//  CharacterListDelegate.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 23/01/22.
//

import UIKit

class CharacterListDelegate<T>: NSObject, UITableViewDelegate {

    private var items: [T]!
    var didSelect: (T) -> Void = {_ in }

    init(items: [T], didSelect: @escaping (T) -> Void) {
        self.items = items
        self.didSelect = didSelect
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        self.didSelect(item)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  CharacterListDataSource.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit

class CharacterListDataSource<CELL: MarvelCharacterListItemCell, T>: NSObject, UITableViewDataSource {

    private var cellIdentifier: String!
    private var items: [T]!
    var configureCell: (CELL, T) -> Void = {_, _ in }

    init(cellIdentifier: String,
         items: [T],
         configureCell: @escaping (CELL, T) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? CELL else {
            assertionFailure("Cannot dequeue reusable cell \(CELL.self) with reuseIdentifier: \(CELL.identifier)")
            return UITableViewCell()
        }

        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        cell.selectionStyle = .none
        return cell
    }

}

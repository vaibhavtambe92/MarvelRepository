//
//  CharacterListItemViewModel.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation

protocol CharacterListItemViewModelProtocol {
    var id: Int { get }
    var name: String { get }
    var thumbnailUrl: URL? { get }
}

struct CharacterListItemViewModel: CharacterListItemViewModelProtocol, Equatable {
    let id: Int
    let name: String
    let thumbnailUrl: URL?
}

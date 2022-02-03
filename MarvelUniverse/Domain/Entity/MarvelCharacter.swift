//
//  MarvelCharacter.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 21/01/22.
//

import Foundation

struct MarvelCharacter: Equatable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnailImageUrl: URL?
}

struct MarvelCharacterPage {
    let offset: Int
    let totalCharacters: Int
    let marvelCharacters: [MarvelCharacter]
}

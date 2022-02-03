//
//  MarvelCharacterDetails.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 25/01/22.
//

import Foundation

struct MarvelCharacterDetails: Equatable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnailImageUrl: URL?
    let comics: [String]
    let stories: [String]
    let events: [String]
    let series: [String]
}

struct MarvelCharacterDetailPage {
    let marvelCharacters: [MarvelCharacterDetails]
}

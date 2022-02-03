//
//  MarvelChracterDTO.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 02/02/22.
//

import Foundation

struct MarvelCharacterDTO: Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String?
    let urls: [Url]
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let events: Events
    let series: Series
}

struct Url: Decodable {
    let type: String
    let url: String
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
}

struct Comics: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [Items]
}

struct Items: Decodable {
    let resourceURI: String
    let name: String
}

struct Stories: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [StoriesItems]
}

struct StoriesItems: Decodable {
    let resourceURI: String
    let name: String
    let type: String
}

struct Events: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [Items]
}

struct Series: Decodable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [Items]
}

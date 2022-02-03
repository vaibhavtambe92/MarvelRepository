//
//  DataProvider.swift
//  MarvelUniverseTests
//
//  Created by Vaibhav Tambe on 26/01/22.
//

import UIKit
@testable import MarvelUniverse

final class MockDataProvider {

    private static let imageURL = URL(string: "default.jpg")

    static let marvelPage: [MarvelCharacterPage] = {
        let page1 = MarvelCharacterPage(offset: 0,
                                        totalCharacters: 0,
                                        marvelCharacters: [MarvelCharacter(id: 1,
                                                                           name: "Iron man",
                                                                           description: "avenger",
                                                                           modified: "",
                                                                           thumbnailImageUrl: imageURL)])
        let page2 = MarvelCharacterPage(offset: 0,
                                        totalCharacters: 0,
                                        marvelCharacters: [MarvelCharacter(id: 2,
                                                                           name: "SpiderMan",
                                                                           description: "avenger",
                                                                           modified: "",
                                                                           thumbnailImageUrl: imageURL)])
        return [page1, page2]
    }()

    static let marvelDetails: MarvelCharacterDetails = {
        return MarvelCharacterDetails(id: 1,
                                      name: "Iron man",
                                      description: "avenger",
                                      modified: "",
                                      thumbnailImageUrl: imageURL,
                                      comics: [],
                                      stories: [],
                                      events: [],
                                      series: [])
    }()

    static let marvelListDTO: MarvelCharacterResponseDTO = {
        let thumbnail = Thumbnail(path: "default",
                                  extension: "jpg")
        let comics = Comics(available: 1,
                            returned: 1,
                            collectionURI: "",
                            items: [])
        let stories = Stories(available: 1,
                              returned: 1,
                              collectionURI: "",
                              items: [])
        let events = Events(available: 1,
                            returned: 1,
                            collectionURI: "",
                            items: [])
        let series = Series(available: 1,
                            returned: 1,
                            collectionURI: "",
                            items: [])
        return MarvelCharacterResponseDTO(code: 200,
                                          status: "approve",
                                          copyright: "marvel",
                                          attributionText: "",
                                          attributionHTML: "",
                                          data: MarvelData(offset: 0,
                                                           limit: 0,
                                                           total: 1,
                                                           count: 1,
                                                           results: [MarvelCharacterDTO(id: 1,
                                                                                        name: "Iron man",
                                                                                        description: "avenger",
                                                                                        modified: "",
                                                                                        resourceURI: "",
                                                                                        urls: [],
                                                                                        thumbnail: thumbnail,
                                                                                        comics: comics,
                                                                                        stories: stories,
                                                                                        events: events,
                                                                                        series: series)]),
                                          etag: "")
    }()

    static let imageData: Data = {
        return UIImage(named: "default")!.jpegData(compressionQuality: 1)!
    }()

    static let marvelCharacter: MarvelCharacter = {
        return MarvelCharacter(id: 1,
                               name: "Iron man",
                               description: "avenger",
                               modified: "",
                               thumbnailImageUrl: imageURL)
    }()
}

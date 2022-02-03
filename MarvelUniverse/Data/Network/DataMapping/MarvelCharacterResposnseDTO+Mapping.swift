//
//  MarvelCharacterResposnseDTO+Mapping.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation

extension MarvelCharacterResponseDTO {
    func toDomain() -> MarvelCharacterPage {
        return .init(offset: data.offset,
                     totalCharacters: data.total,
                     marvelCharacters: data.results.map { $0.toDomain()})
    }

    func toDomainDetail() -> MarvelCharacterDetailPage {
        return .init(marvelCharacters: data.results.map { $0.toDomainDetails() })
    }
}

extension MarvelCharacterDTO {
    func toDomain() -> MarvelCharacter {
        return MarvelCharacter(id: id,
                               name: name,
                               description: description,
                               modified: modified,
                               thumbnailImageUrl: thumbnail.toDomain())
    }

    func toDomainDetails() -> MarvelCharacterDetails {
        return MarvelCharacterDetails(id: id,
                                      name: name,
                                      description: description,
                                      modified: modified,
                                      thumbnailImageUrl: thumbnail.toDomain(),
                                      comics: comics.toDomain(),
                                      stories: stories.toDomain(),
                                      events: events.toDomain(),
                                      series: series.toDomain())
    }
}

extension Thumbnail {
    func toDomain() -> URL? {
        let urlString = path + "." + `extension`
        return URL(string: urlString)
    }
}

extension Comics {
    func toDomain() -> [String] {
        return items.map { $0.toDomain()}
    }
}

extension Items {
    func toDomain() -> String {
        return name
    }
}

extension Stories {
    func toDomain() -> [String] {
        return items.map { $0.toDomain()}
    }
}

extension StoriesItems {
    func toDomain() -> String {
        return name
    }
}

extension Events {
    func toDomain() -> [String] {
        return items.map { $0.toDomain()}
    }
}

extension Series {
    func toDomain() -> [String] {
        return items.map { $0.toDomain()}
    }
}

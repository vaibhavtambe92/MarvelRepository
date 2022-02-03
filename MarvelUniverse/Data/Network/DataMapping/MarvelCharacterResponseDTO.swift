//
//  MarvelResponseDTO.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 02/02/22.
//

import Foundation

struct MarvelCharacterResponseDTO: Decodable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: MarvelData
    let etag: String
}

struct MarvelData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelCharacterDTO]
}

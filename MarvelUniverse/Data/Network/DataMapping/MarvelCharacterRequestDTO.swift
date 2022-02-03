//
//  MarvelCharacterRequestDTO.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 21/01/22.
//

import Foundation

struct MarvelCharacterRequestDTO: Encodable, Equatable {
    let limit: Int
    let offset: Int
}

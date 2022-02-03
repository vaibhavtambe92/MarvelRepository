//
//  MarvelCharacterRepositoryProtocol.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 21/01/22.
//

import Foundation

protocol MarvelCharacterListRepositoryProtocol {
    func fetchMarvelList(page: Int, completion: @escaping (Result<MarvelCharacterPage, Error>) -> Void) -> Cancellable?
}

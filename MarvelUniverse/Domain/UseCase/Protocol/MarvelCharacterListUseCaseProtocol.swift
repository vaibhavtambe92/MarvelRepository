//
//  MarvelCharacterListUseCaseProtocol.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 21/01/22.
//

import Foundation

protocol MarvelCharacterListUseCaseProtocol {
    func executeMarvelList(page: Int,
                           completion: @escaping (Result<MarvelCharacterPage, Error>) -> Void) -> Cancellable?
}

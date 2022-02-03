//
//  MarvelCharacterDetailUseCase.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 25/01/22.
//

import Foundation

protocol MarvelCharacterDetailsUseCaseProtocol {
    func executeMarvelCharacter(characterId: Int,
                                completion: @escaping (Result<MarvelCharacterDetails, Error>) -> Void) -> Cancellable?
}

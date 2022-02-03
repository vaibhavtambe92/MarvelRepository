//
//  APIRequestProvider.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 22/01/22.
//

import Foundation
import Alamofire

struct APIRequestProvider {

    static func getMarvelCharacterList(with marvelCharacterRequestDTO: MarvelCharacterRequestDTO) -> APIRequest {
        return APIRequest(method: .get, parametersEncodable: marvelCharacterRequestDTO)
    }

    static func getMarvelCharacter(with characterId: Int) -> APIRequest {
        return APIRequest(path: "/\(characterId)", method: .get)
    }
}

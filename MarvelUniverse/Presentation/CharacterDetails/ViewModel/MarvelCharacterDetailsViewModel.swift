//
//  MarvelCharacterDetailsViewModel.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 25/01/22.
//

import Foundation

private enum CharacterDetailsConstants {
    static let genericError = "Marvel_ErrorTitle"
    static let noConnectionError = "Marvel_NoInternetErrorTitle"
    static let comics = "comics"
    static let series = "series"
    static let events = "events"
    static let stories = "stories"
}

protocol MarvelCharacterDetailsViewModelInput {
    func getMarvelCharacter()
}

protocol MarvelCharacterDetailsViewModelOutput {
    var marvelCharacter: Observable<MarvelCharacterDetails?> { get }
    var loading: Observable<Bool> { get }
    var error: Observable<String> { get }
    var comics: String { get }
    var series: String { get }
    var events: String { get }
    var stories: String { get }
}

protocol MarvelCharacterDetailsViewModelProtocol: MarvelCharacterDetailsViewModelInput,
                                                  MarvelCharacterDetailsViewModelOutput {}

final class MarvelCharacterDetailsViewModel: MarvelCharacterDetailsViewModelProtocol {

    private var marvelCharacterLoadTask: Cancellable? { willSet { marvelCharacterLoadTask?.cancel() } }
    private let marvelCharacterDetailsUseCase: MarvelCharacterDetailsUseCaseProtocol
    private let characterId: Int

    // MARK: - Output
    let marvelCharacter: Observable<MarvelCharacterDetails?> = Observable(nil)
    let loading: Observable<Bool> = Observable(false)
    let error: Observable<String> = Observable("")

    private let errorTitle: String = CharacterDetailsConstants.genericError.localized
    private let noInternetErrorTitle: String = CharacterDetailsConstants.noConnectionError.localized
    let comics = CharacterDetailsConstants.comics.localized
    let stories = CharacterDetailsConstants.stories.localized
    let events = CharacterDetailsConstants.stories.localized
    let series = CharacterDetailsConstants.series.localized

    init(characterId: Int, marvelCharacterDetailsUseCase: MarvelCharacterDetailsUseCaseProtocol) {
        self.marvelCharacterDetailsUseCase = marvelCharacterDetailsUseCase
        self.characterId = characterId
    }
}

extension MarvelCharacterDetailsViewModel {

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? noInternetErrorTitle : errorTitle
    }

    func getMarvelCharacter() {
        loading.value = true

        marvelCharacterLoadTask = marvelCharacterDetailsUseCase.executeMarvelCharacter(characterId:
                                                                                        characterId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let marvelCharacter):
                self.marvelCharacter.value = marvelCharacter
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = false
        }
    }
}

//
//  CharacterListViewModel.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import Foundation

private enum CharacterListContants {
    static let screenTitle = "Marvel_Universe"
    static let genericErrorMessage = "Marvel_ErrorTitle"
    static let noConnectionErrorMessage = "Marvel_NoInternetErrorTitle"
}

struct MarvelCharacterListViewModelActions {
    let showMarvelCharacterDetails: (Int) -> Void
}

protocol MarvelCharacterListViewModelInputProtocol {
    func didSelectItem(character: CharacterListItemViewModel)
    func didLoadNextPage()
}

enum MarvelCharacterListViewModelLoading {
    case emptyScreen
    case nextPage
}

protocol MarvelCharacterListViewModelOutPutProtocol {
    var characters: Observable<[CharacterListItemViewModel]> { get }
    var loading: Observable<MarvelCharacterListViewModelLoading?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
}

protocol CharacterListViewModelProtocol: MarvelCharacterListViewModelInputProtocol,
                                         MarvelCharacterListViewModelOutPutProtocol {}

final class CharacterListViewModel: CharacterListViewModelProtocol {

    private let marvelCharacterListUseCase: MarvelCharacterListUseCaseProtocol
    private let actions: MarvelCharacterListViewModelActions?

    private var currentOffset: Int = 0
    private var totalCharacterCount: Int = 1
    private var hasMorePages: Bool { currentOffset < totalCharacterCount }
    private var nextOffset: Int { hasMorePages ? currentOffset + 10 : currentOffset }

    private var pages: [MarvelCharacterPage] = []
    private var marvelCharacterLoadTask: Cancellable? { willSet { marvelCharacterLoadTask?.cancel() } }

    // MARK: Output Protocol
    let characters: Observable<[CharacterListItemViewModel]> = Observable([])
    let error: Observable<String> = Observable("")
    let loading: Observable<MarvelCharacterListViewModelLoading?> = Observable(.none)
    var isEmpty: Bool { return characters.value.isEmpty }
    let screenTitle: String = CharacterListContants.screenTitle.localized
    private let errorTitle: String = CharacterListContants.genericErrorMessage.localized
    private let noInternetErrorTitle: String = CharacterListContants.noConnectionErrorMessage.localized

    // MARK: - initialisers
    init(marvelCharactersUseCase: MarvelCharacterListUseCaseProtocol,
         actions: MarvelCharacterListViewModelActions?) {
        self.marvelCharacterListUseCase = marvelCharactersUseCase
        self.actions = actions
    }

    private func loadNextPage(loading: MarvelCharacterListViewModelLoading) {
        self.loading.value = loading
        let nextPageIndex = isEmpty ? 0 : nextOffset
        marvelCharacterLoadTask = marvelCharacterListUseCase.executeMarvelList(page: nextPageIndex,
                                                                               completion: { [weak self] result in
                                                                                guard let self = self else { return }
                                                                                switch result {
                                                                                case .success(let characterPage):
                                                                                    self.appendPage(characterPage)
                                                                                case .failure(let error):
                                                                                    self.handle(error: error)
                                                                                }
                                                                                self.loading.value = .none
                                                                               })
    }

    private func appendPage(_ characterPage: MarvelCharacterPage) {
        currentOffset = characterPage.offset
        totalCharacterCount = characterPage.totalCharacters

        pages = pages
            .filter { $0.offset != characterPage.offset }
            + [characterPage]

        characters.value = pages.characters.map { CharacterListItemViewModel(id: $0.id,
                                                                             name: $0.name,
                                                                             thumbnailUrl: $0.thumbnailImageUrl) }
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? noInternetErrorTitle : errorTitle
    }

}

extension CharacterListViewModel {
    // MARK: - InputProtocol

    func didLoadNextPage() {
        guard hasMorePages, loading.value != .nextPage else { return }
        let loading: MarvelCharacterListViewModelLoading = characters.value.isEmpty ? .emptyScreen : .nextPage
        loadNextPage(loading: loading)
    }

    func didSelectItem(character: CharacterListItemViewModel) {
        actions?.showMarvelCharacterDetails(character.id)
    }
}

private extension Array where Element == MarvelCharacterPage {
    var characters: [MarvelCharacter] { flatMap { $0.marvelCharacters } }
}

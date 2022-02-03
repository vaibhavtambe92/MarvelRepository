//
//  CharacterListViewController.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit

final class CharacterListViewController: BaseViewController, StoryboardInstantiable {

    @IBOutlet private weak var emptyDataLabel: UILabel!
    @IBOutlet private weak var characterTableView: UITableView!
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    private var characterListDataSource: CharacterListDataSource<MarvelCharacterListItemCell,
                                                                 CharacterListItemViewModel>!
    private var characterListDelegate: CharacterListDelegate<CharacterListItemViewModel>!
    private var characterListViewModel: CharacterListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        bindViewModelToController()
    }

    static func create(with viewModel: CharacterListViewModelProtocol) -> CharacterListViewController {
        let view = CharacterListViewController.instantiateViewController()
        view.characterListViewModel = viewModel
        return view
    }

    private func bindViewModelToController() {
        characterListViewModel.characters.observe {[weak self] _ in self?.updateItems() }
        characterListViewModel.loading.observe { [weak self] in self?.updateLoading($0) }
        characterListViewModel.error.observe { [weak self] in self?.showError($0) }
        characterListViewModel.didLoadNextPage()
    }

    private func setupTableView() {
        characterTableView.register(UINib(nibName: MarvelCharacterListItemCell.identifier,
                                          bundle: nil),
                                    forCellReuseIdentifier: MarvelCharacterListItemCell.identifier)
        characterTableView.rowHeight = UITableView.automaticDimension
        characterTableView.estimatedRowHeight = 600
    }

    private func updateDataSource() {
        characterListDataSource = CharacterListDataSource(cellIdentifier: MarvelCharacterListItemCell.identifier,
                                                          items: characterListViewModel.characters.value,
                                                          configureCell: { [weak self] (cell, characterItem) in
                                                            guard let self = self else { return }
                                                            cell.setupCell(viewModel: characterItem)
                                                            let characters = self.characterListViewModel.characters
                                                            if characters.value.last == characterItem {
                                                                self.characterListViewModel.didLoadNextPage()
                                                            }
                                                          })

        characterListDelegate = CharacterListDelegate(items: characterListViewModel.characters.value,
                                                      didSelect: { [weak self] character in
                                                        guard let self = self else { return }
                                                        self.characterListViewModel.didSelectItem(character:
                                                                                                    character)
                                                      })

        characterTableView.dataSource = characterListDataSource
        characterTableView.delegate = characterListDelegate
        characterTableView.rowHeight = UITableView.automaticDimension
        characterTableView.reloadData()
    }

    private func updateLoading(_ loading: MarvelCharacterListViewModelLoading?) {
        emptyDataLabel.isHidden = true
        showLoader(show: false)

        switch loading {
        case .emptyScreen:
            characterTableView.isHidden = true
            emptyDataLabel.isHidden = true
            showLoader(show: true)
        case .nextPage:
            characterTableView.isHidden = false
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: characterTableView.frame.width,
                                                                       height: 44))
            characterTableView.tableFooterView = nextPageLoadingSpinner
        case .none:
            characterTableView.isHidden = characterListViewModel.isEmpty
            emptyDataLabel.isHidden = !characterListViewModel.isEmpty
        }
    }

    private func setupViews() {
        title = characterListViewModel.screenTitle
    }

    private func updateItems() {
        DispatchQueue.main.async {
            self.updateDataSource()
        }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        characterTableView.isHidden = true
        emptyDataLabel.isHidden = false
        emptyDataLabel.text = error
    }

}

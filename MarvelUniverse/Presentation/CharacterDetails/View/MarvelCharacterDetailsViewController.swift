//
//  MarvelCharacterDetailsViewController.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 25/01/22.
//

import UIKit

final class MarvelCharacterDetailsViewController: BaseViewController, StoryboardInstantiable {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var characterDetailsLabel: UILabel!
    @IBOutlet private weak var characterTitleLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var detailsStackView: UIStackView!

    private var characterDetailsViewModel: MarvelCharacterDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelToController()
    }

    static func create(with viewModel: MarvelCharacterDetailsViewModelProtocol)
    -> MarvelCharacterDetailsViewController {
        let view = MarvelCharacterDetailsViewController.instantiateViewController()
        view.characterDetailsViewModel = viewModel
        return view
    }

    private func bindViewModelToController() {
        characterDetailsViewModel.marvelCharacter.observe {[weak self] _ in self?.updateUI() }
        characterDetailsViewModel.error.observe { [weak self] in self?.showError($0) }
        characterDetailsViewModel.loading.observe { [weak self] in self?.updateLoading($0) }
        characterDetailsViewModel.getMarvelCharacter()
    }

    private func updateUI() {
        characterTitleLabel.text = characterDetailsViewModel.marvelCharacter.value?.name
        characterDetailsLabel.text = characterDetailsViewModel.marvelCharacter.value?.description
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width/2
        guard let url = characterDetailsViewModel.marvelCharacter.value?.thumbnailImageUrl else { return }
        thumbnailImageView.kf.setImage(with: url)
        addDetailsInStackView()
    }

    private func showError(_ error: String) {
        contentView.isHidden = true
        errorLabel.isHidden = false
    }

    private func updateLoading(_ isLoading: Bool) {
        errorLabel.isHidden = true
        contentView.isHidden = isLoading
        showLoader(show: isLoading)
    }

    private func addDetailsInStackView() {
        addSection(title: characterDetailsViewModel.comics,
                   elements: characterDetailsViewModel.marvelCharacter.value?.comics)
        addSection(title: characterDetailsViewModel.series,
                   elements: characterDetailsViewModel.marvelCharacter.value?.series)
        addSection(title: characterDetailsViewModel.stories,
                   elements: characterDetailsViewModel.marvelCharacter.value?.stories)
        addSection(title: characterDetailsViewModel.events,
                   elements: characterDetailsViewModel.marvelCharacter.value?.events)
    }

    private func addLabelToStack(with text: String, font: UIFont) {
        let label = UILabel()
        label.text = text
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.addArrangedSubview(label)
    }

    private func addSection(title: String, elements: [String]?) {
        if let section = elements, !section.isEmpty {
            addLabelToStack(with: title, font: MarvelConstant.MarvelFonts.boldTitle)
            section.forEach { element in
                addLabelToStack(with: element, font: MarvelConstant.MarvelFonts.caption)
            }
        }
    }

}

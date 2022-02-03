//
//  CharacterListItemCell.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 20/01/22.
//

import UIKit
import Kingfisher

class MarvelCharacterListItemCell: UITableViewCell {

    static let identifier: String = String(describing: MarvelCharacterListItemCell.self)

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!

    func setupCell(viewModel: CharacterListItemViewModelProtocol) {
        updateUI(viewModel: viewModel)
    }

    private func updateUI(viewModel: CharacterListItemViewModelProtocol) {
        characterNameLabel.text = viewModel.name
        updateThumbnailImage(viewModel: viewModel)
    }

    private func updateThumbnailImage(viewModel: CharacterListItemViewModelProtocol) {
        thumbnailImageView.image = nil
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width/2

        guard let imageUrl = viewModel.thumbnailUrl else { return }
        thumbnailImageView.kf.setImage(with: imageUrl)
    }
}

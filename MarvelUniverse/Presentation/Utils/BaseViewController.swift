//
//  BaseViewController.swift
//  MarvelUniverse
//
//  Created by Vaibhav Tambe on 23/01/22.
//

import UIKit

class BaseViewController: UIViewController {

    private var loader: UIActivityIndicatorView?

    func showLoader(show: Bool) {
        if show {
            showLoader()
        } else {
            hideLoader()
        }
    }

    private func showLoader() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter {$0.activationState == .foregroundActive}
                .compactMap {$0 as? UIWindowScene}
                .first?.windows
                .filter {$0.isKeyWindow}.first
            if self.loader == nil, let window = keyWindow {
                let frame = UIScreen.main.bounds
                let loader = UIActivityIndicatorView(frame: frame)
                loader.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                loader.style = .large
                window.addSubview(loader)

                loader.startAnimating()
                self.loader = loader
            }
        }
    }

    private func hideLoader() {
        DispatchQueue.main.async {
            guard let spinner = self.loader else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.loader = nil
        }
    }
}

//
//  BaseViewController.swift
//  ChannelViewer
//
//  Created by subhajit halder on 23/05/23.
//

import UIKit

class BaseViewController: UIViewController {
    let LOADER_TAG = 101
    private var loaderAlert = UIAlertController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        hideLoadingIndicator()
    }
}

extension BaseViewController {
    func showLoadingIndicator(with message: String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            loaderAlert = UIAlertController(title: nil, message: message ?? "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.large
            loadingIndicator.startAnimating()
            loaderAlert.view.addSubview(loadingIndicator)
            loaderAlert.view.tag = LOADER_TAG
            self.present(loaderAlert, animated: true, completion: nil)
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = `self` else { return }
            self.loaderAlert.dismiss(animated: true, completion: nil)
        }
    }
}

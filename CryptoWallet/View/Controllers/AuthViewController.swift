//
//  AuthViewController.swift
//  CryptoWallet
//
//  Created by Гамлет on 7.11.22.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    
    private let alertManager = AlertManager()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  .green
        button.setTitle("Log in", for: .normal)
        button.setImage(UIImage(systemName: "person.badge.key"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func configureView() {
        view.backgroundColor = .systemCyan
        view.addSubview(loginButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
        listenVM()
    }
    
    private func listenVM() {
        alertManager.feedBackStatus = { [weak self] statusAlert in
            self?.present(statusAlert, animated: true)
        }
    }
    
    @objc func logIn() {
        present(alertManager.showLoginAlert(), animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        let loginButtonConstraints = [
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 10),
            loginButton.widthAnchor.constraint(equalToConstant: view.bounds.height / 7)
        ]
        NSLayoutConstraint.activate(loginButtonConstraints)
    }
}



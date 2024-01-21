//
//  DetailViewController.swift
//  CryptoWallet
//
//  Created by Гамлет on 6.11.22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemIndigo
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDailyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  .systemOrange
        button.setTitle("Logout", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 15
        button.setImage(UIImage(systemName: "arrow.up.square"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public func configure(with viewModel: CryptoTableViewCellModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price.cleanPriceStr + " $"
        symbolLabel.text = viewModel.symbol
        priceChangeDailyLabel.text = viewModel.priceChangeDaily.cleanPriceStr + "%"
        priceChangeDailyLabel.changeColorByPercentchange()
        priceChangeDailyLabel.changeArrowByPercentchange()
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(symbolLabel)
        view.addSubview(logoutButton)
        view.addSubview(priceChangeDailyLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        let nameLabelConstraints = [
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
        let symbolLabelConstraints = [
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            symbolLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
        ]
        let priceLabelConstraints = [
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        let logoutButtonConstraints = [
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            logoutButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 10),
            logoutButton.widthAnchor.constraint(equalToConstant: view.bounds.height / 7)
        ]
        let priceChangeDailyLabelConstraints = [
            priceChangeDailyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            priceChangeDailyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(logoutButtonConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(symbolLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(priceChangeDailyLabelConstraints)
    }
    
    @objc private func logout() {
        AuthService.shared.logout()
    }
}

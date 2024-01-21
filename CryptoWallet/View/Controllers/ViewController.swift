//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Гамлет on 28.10.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataManager: (MVVMProtocolIn & MVVMProtocolOut)?
    
    var viewModels = [CryptoTableViewCellModel]()
    
    private var sorting: SortCrypto = SortCrypto.sortByHigherPercentChanging
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemGreen
        return indicator
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        view.addSubview(tableView)

        view.addSubview(logoutButton)
        view.addSubview(loadingIndicator)
        tableView.dataSource = self
        tableView.delegate = self
        configureNavbar()
        loadingIndicator.startAnimating()
        setupConstraints()
        dataManager?.asyncGroup()
        listenViewModel()
    }

    private func setupConstraints() {
        let logoutButtonConstraints = [
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.bounds.height / 45)),
            logoutButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 15),
            logoutButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 2)
        ]
        
        let tableViewContraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -10)
        ]
        
        let indicatorConstraints = [
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewContraints)
        NSLayoutConstraint.activate(logoutButtonConstraints)
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    
    private func configureNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortCrypto))
        navigationController?.navigationBar.tintColor = .systemCyan
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CryptoTableViewCell.identifier,
            for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let crypto = viewModels[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.configure(with: crypto)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func listenViewModel() {
        dataManager?.setCryptoData = { [weak self] cryptos in
            self?.viewModels = cryptos
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func sortCrypto() {
        switch sorting {
        case .sortByHigherPercentChanging:
            self.viewModels.sort { first, second -> Bool in
                first.priceChangeDaily > second.priceChangeDaily
            }
            sorting = .sortByLowerPercentChanging
        case .sortByLowerPercentChanging:
            self.viewModels.sort { first, second -> Bool in
                first.priceChangeDaily < second.priceChangeDaily
            }
            sorting = .sortByHigherPercentChanging
        }
        
        tableView.reloadData()
    }
    
    @objc private func logout() {
        AuthService.shared.logout()
    }
}


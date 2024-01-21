//
//  CryptoTableViewCell.swift
//  CryptoWallet
//
//  Created by Гамлет on 28.10.22.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    static let identifier = "CryptoTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemIndigo
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDailyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemCyan
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        
        let priceChangeDailyLabelConstraints = [
            priceChangeDailyLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            priceChangeDailyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
        ]
        let symbolLabelConstraints = [
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            symbolLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
        ]
        let priceLabelConstraints = [
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(symbolLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(priceChangeDailyLabelConstraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceChangeDailyLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with crypto: CryptoTableViewCellModel) {
        nameLabel.text = crypto.name
        priceLabel.text = crypto.price.cleanPriceStr + " $"
        symbolLabel.text = crypto.symbol
        priceChangeDailyLabel.text = crypto.priceChangeDaily.cleanPriceStr + "%"
        priceChangeDailyLabel.changeColorByPercentchange()
        priceChangeDailyLabel.changeArrowByPercentchange()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil
        priceChangeDailyLabel.text = nil
    }
}

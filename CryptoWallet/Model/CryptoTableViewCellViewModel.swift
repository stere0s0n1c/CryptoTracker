//
//  CryptoTableViewCellViewModel.swift
//  CryptoWallet
//
//  Created by Гамлет on 23.11.22.
//

import Foundation

final class CryptoTableViewCellModel {
    let name: String
    let symbol: String
    let price: Double
    let priceChangeDaily: Double
    let iconUrl: URL?
    var iconData: Data?
    init(name: String, symbol: String, price: Double, priceChangeDaily: Double, iconUrl: URL?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.priceChangeDaily = priceChangeDaily
        self.iconUrl = iconUrl
    }
}

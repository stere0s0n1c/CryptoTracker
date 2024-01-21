//
//  CryptoNames.swift
//  CryptoWallet
//
//  Created by Гамлет on 28.11.22.
//

import Foundation

enum CryptoNames: String, CaseIterable {
    case btc, eth, tron, polkadot, dogecoin, tether, stellar, cardano, xrp
    var id: String {  self.rawValue }
}

enum CryptoSymbols: String, CaseIterable {
    case btc, eth, dot, usdt, xrp, ada, doge, xlm, trx
    var id: String {  self.rawValue }
}

enum SortCrypto {
    case sortByHigherPercentChanging
    case sortByLowerPercentChanging
}

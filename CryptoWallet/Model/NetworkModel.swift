//
//  Models.swift
//  CryptoWallet
//
//  Created by Гамлет on 31.10.22.
//

import Foundation

struct Crypto: Decodable {
    let data: CryptoData
}

struct CryptoData: Decodable {
    let name: String
    let symbol: String
    let marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case marketData = "market_data"
    }
}

struct MarketData: Decodable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}


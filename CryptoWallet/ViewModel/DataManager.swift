//
//  DataManager.swift
//  CryptoWallet
//
//  Created by Гамлет on 23.11.22.
//

import Foundation



final class DataManager: MVVMProtocolIn, MVVMProtocolOut {
        
    var setCryptoData: ([CryptoTableViewCellModel]) -> Void = { _ in }

    func asyncGroup() {
        let aGroup = DispatchGroup()
        var cryptoArr = [CryptoTableViewCellModel]()
        
        for crypto in CryptoNames.allCases {
            aGroup.enter()
            APICaller.shared.getCryptoData(for: crypto) { result in
                switch result {
                case.success(let model):
                    
                    let cryptoCell = CryptoTableViewCellModel(
                        name: model.data.name,
                        symbol: model.data.symbol,
                        price: model.data.marketData.priceUsd,
                        priceChangeDaily: model.data.marketData.percentChangeUsdLast24Hours,
                        iconUrl: URL(string: "https://cryptoicons.org/api/icon/\(model.data.symbol.lowercased())/50")
                    )
                    cryptoArr.append(cryptoCell)
                    
                case.failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                aGroup.leave()
            }
        }
        
        aGroup.notify(queue: .main) { [weak self] in
            cryptoArr.sort { first, second -> Bool in
                first.price > second.price
            }
            self?.setCryptoData(cryptoArr)
        }
    }
}

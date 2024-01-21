//
//  APICaller.swift
//  CryptoWallet
//
//  Created by Гамлет on 28.10.22.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    public func getCryptoData(for cryptoName: CryptoNames,
                              completion: @escaping (Result<Crypto, Error>) -> Void
    ) {
        let url = "https://data.messari.io/api/v1/assets/\(cryptoName.id)/metrics"
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let cryptos = try JSONDecoder().decode(Crypto.self, from: data)
                completion(.success(cryptos))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

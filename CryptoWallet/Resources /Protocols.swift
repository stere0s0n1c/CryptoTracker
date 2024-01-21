//
//  Protocols.swift
//  CryptoWallet
//
//  Created by Гамлет on 15.12.22.
//

import Foundation

protocol MVVMProtocolIn {
    func asyncGroup()
}

protocol MVVMProtocolOut {
    var setCryptoData: ([CryptoTableViewCellModel]) -> Void { get set }
}

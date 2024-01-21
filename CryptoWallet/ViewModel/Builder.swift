//
//  Builder.swift
//  CryptoWallet
//
//  Created by Гамлет on 4.12.22.
//

import Foundation
import UIKit

final class Builder {
    static func build() -> UIViewController {
        let viewC = ViewController()
        let dataM = DataManager()
        viewC.dataManager = dataM
        return viewC
    }
}

//
//  Extensions.swift
//  CryptoWallet
//
//  Created by Гамлет on 13.11.22.
//

import Foundation
import UIKit

extension Double {
    var cleanPriceStr: String {
        String(format: "%1f", self)
    }
}

extension UILabel {

    func changeColorByPercentchange() {
        self.textColor =  self.text?.first == "-" ? .systemRed : .systemGreen
    }
    
    func changeArrowByPercentchange() {
        guard let text = self.text else { return }
        self.text =  self.text?.first == "-" ? "↓" + text : "↑" + text
    }

}

extension UIViewController {
    func createFeedBackAlert(_ message: String, _ isValidFields: Bool) -> UIAlertController {
        let feedBackAlert = UIAlertController(
            title: message,
            message: nil,
            preferredStyle: .alert
        )
        feedBackAlert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
            if isValidFields { AuthService.shared.login() }
        }))
        return feedBackAlert
    }
}


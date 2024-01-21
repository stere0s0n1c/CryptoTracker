//
//  ScreenManager.swift
//  CryptoWallet
//
//  Created by Гамлет on 13.11.22.
//

import Foundation
import UIKit

final class ScreenService {
    
    static let shared = ScreenService()
    private lazy var window = UIWindow(frame: UIScreen.main.bounds)
    
    func showAuthScreen() {
        window.rootViewController = AuthViewController()
        window.makeKeyAndVisible()
    }
    
    func showListScreen() {
        window.rootViewController = UINavigationController(rootViewController: Builder.build())
        window.makeKeyAndVisible()
    }
    
}

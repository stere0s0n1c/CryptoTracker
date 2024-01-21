//
//  AppDelegate.swift
//  CryptoWallet
//
//  Created by Гамлет on 28.10.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AuthService.shared.begin()
        return true
    }

}


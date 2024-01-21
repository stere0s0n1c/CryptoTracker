//
//  AuthService.swift
//  CryptoWallet
//
//  Created by Гамлет on 23.11.22.
//

import Foundation

final class AuthService {
    
    static let shared = AuthService()
    
    private let key: String = "isAuthorized"
    private let userDefaults = UserDefaults.standard
    
    func begin() {
        if userDefaults.bool(forKey: key) {
            ScreenService.shared.showListScreen()
        } else {
            ScreenService.shared.showAuthScreen()
        }
    }
    
    func logout() {
        userDefaults.set(false, forKey: key)
        ScreenService.shared.showAuthScreen()
    }
    
    func login() {
        userDefaults.set(true, forKey: key)
        ScreenService.shared.showListScreen()
    }
}

//
//  AuthManager.swift
//  CryptoWallet
//
//  Created by Гамлет on 3.12.22.
//

import Foundation
import UIKit

final class AlertManager {
    private let userName = "user1"
    private let userPassword = "12345"
    private let loginTag = 0
    private let passwordTag = 1
    private let getTextByTag: (UIAlertController, Int) -> String? = { inputAlert, tag in inputAlert.textFields?.filter({ field in field.tag == tag}).first?.text }
    private lazy var inputAlertText = "Логин: \(userName) \n Пароль: \(userPassword)"
    var feedBackStatus: (UIAlertController) -> Void = {_ in }
    
    func showLoginAlert() -> UIAlertController {
        
        func validate(_ textField: UITextField) {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main,
                using: { _ in
                    if let loginText = self.getTextByTag(inputAlert, self.loginTag),
                       loginText.count > 4,
                       let passwordText = self.getTextByTag(inputAlert, self.passwordTag),
                       passwordText.count > 4
                    {
                        LoginAction.isEnabled = true
                        inputAlert.message = ""
                    } else {
                        LoginAction.isEnabled = false
                        inputAlert.message = self.inputAlertText
                    }
                }
            )
        }
        
        let inputAlert = UIAlertController(
            title: "Log in",
            message: inputAlertText,
            preferredStyle: .alert
        )
        
        inputAlert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
        )
        
        let LoginAction = UIAlertAction(
            title: "Login",
            style: .default,
            handler: { _ in
                if let loginText = self.getTextByTag(inputAlert, self.loginTag),
                   let passwordText = self.getTextByTag(inputAlert, self.passwordTag),
                   loginText == self.userName && passwordText == self.userPassword
                {
                    self.feedBackStatus(UIViewController().createFeedBackAlert("Успешно авторизован", true))
                } else {
                    self.feedBackStatus(UIViewController().createFeedBackAlert("Неверный логин или пароль", false))
                }
            }
        )
        
        inputAlert.addAction(LoginAction)
        
        inputAlert.addTextField { textField in
            textField.placeholder = "Login"
            textField.tag = self.loginTag
            validate(textField)
        }

        inputAlert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.tag = self.passwordTag
            validate(textField)
        }
        
        LoginAction.isEnabled = false
        return inputAlert
    }
}

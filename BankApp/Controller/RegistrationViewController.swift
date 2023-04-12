//
//  RegistrationViewController.swift
//  BankApp
//
//  Created by David Klaric on 23.02.2023..
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Labels
    let titleLabel = UILabel()
    let passwordTextField = UITextField()
    let passwordRepeatTextField = UITextField()
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        passwordTextField.delegate = self
        passwordRepeatTextField.delegate = self
        
        setupTitle()
        setupPasswordRepeatTextField()
        setupPasswordTextField()
        setupButton()
    }
    
    // MARK: - UI Setup Functions
    func setupTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .systemYellow
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.layer.cornerRadius = 25
        titleLabel.layer.masksToBounds = true
        titleLabel.text = "Registration"
        
        Constraints.setupRegistrationTitle(label: titleLabel, view: view)
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.textAlignment = .center
        passwordTextField.keyboardType = .numberPad
        passwordTextField.clipsToBounds = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.placeholder = "Enter your password"
        
        Constraints.setupRegistrationPassword(password: passwordTextField, passwordRepeat: passwordRepeatTextField, view: view)
    }
    
    func setupPasswordRepeatTextField() {
        view.addSubview(passwordRepeatTextField)
        
        passwordRepeatTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordRepeatTextField.backgroundColor = .systemGray5
        passwordRepeatTextField.textAlignment = .center
        passwordRepeatTextField.keyboardType = .numberPad
        passwordRepeatTextField.clipsToBounds = true
        passwordRepeatTextField.isSecureTextEntry = true
        passwordRepeatTextField.layer.cornerRadius = 10
        passwordRepeatTextField.placeholder = "Repeat your password"
        
        Constraints.setupRegistrationRepeatedPassword(passwordRepeat: passwordRepeatTextField, view: view)   
    }
    
    func setupButton() {
        view.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.configuration = .filled()
        registerButton.configuration?.baseBackgroundColor = .systemYellow
        registerButton.configuration?.baseForegroundColor = .black
        registerButton.configuration?.title = "Register"
        
        Constraints.setupRegistrationButton(button: registerButton, passwordRepeat: passwordRepeatTextField)
        
        // add button action
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        if textField == passwordTextField || textField == passwordRepeatTextField {
            let currentString = (textField.text ?? "") as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxLength
        }
        return true
    }
    
    // MARK: - Objective C
    @objc func registerButtonTapped() {
        guard let password = passwordTextField.text, !password.isEmpty,
              let repeatedPassword = passwordRepeatTextField.text, !repeatedPassword.isEmpty else {
            // one or both textfields are empty
            let alert = UIAlertController(title: "Oops!", message: "Make sure text fields are not empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        if password == repeatedPassword {
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.synchronize()
            
            let destinationVC = ContainerViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
            print("registered")
        } else {
            // Authentication failed, show error mesage
            let alert = UIAlertController(title: "Oops!", message: "Make sure you rewrote password correctly!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

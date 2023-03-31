//
//  LoginViewController.swift
//  BankApp
//
//  Created by David Klaric on 23.02.2023..
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
        
    //MARK: - Labels
    let titleLabel = UILabel()
    let passwordTextField = UITextField()
    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordTextField.delegate = self
        navigationController?.isNavigationBarHidden = true
        
        setupTitle()
        setupTextField()
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
        titleLabel.text = "Log in"
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 130),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.textAlignment = .center
        passwordTextField.keyboardType = .numberPad
        passwordTextField.clipsToBounds = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.placeholder = "Enter your password!"
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 220),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupButton() {
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.configuration = .filled()
        loginButton.configuration?.baseBackgroundColor = .systemYellow
        loginButton.configuration?.baseForegroundColor = .black
        loginButton.configuration?.title = "Log in"
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 90),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // add button action
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString = (passwordTextField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
    
    // MARK: - Objective C
    @objc func loginButtonTapped() {
        let enteredPassword = passwordTextField.text
        
        // retrieve the saved password from UserDefaults
        let savedPassword = UserDefaults.standard.string(forKey: "password")
        
        if enteredPassword == "" {
            // Authentication failed, show error message
            let alert = UIAlertController(title: "Oops!", message: "Empty password!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if let enteredPassword = enteredPassword, enteredPassword.count < 4 {
            // Authentication failed, password not long enough
            let alert = UIAlertController(title: "Oops!", message: "Password is atleast 4 characters long!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if let enteredPassword = enteredPassword,
                  let savedPassword = savedPassword, enteredPassword != savedPassword {
            // Authentication failed, incorrect password
            let alert = UIAlertController(title: "Oops!", message: "Incorrect password!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Authentication successful, navigate to next view
            let destinationVC = ContainerViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

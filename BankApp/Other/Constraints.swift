//
//  Constraints.swift
//  BankApp
//
//  Created by David Klaric on 06.04.2023..
//

import UIKit

class Constraints {
    //MARK: - Registration View
    static func setupRegistrationTitle(label: UILabel, view: UIView) {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.widthAnchor.constraint(equalToConstant: 200),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    static func setupRegistrationPassword(password: UITextField, passwordRepeat: UITextField, view: UIView) {
        NSLayoutConstraint.activate([
            password.bottomAnchor.constraint(equalTo: passwordRepeat.topAnchor, constant: -30),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalToConstant: 250),
            password.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    static func setupRegistrationRepeatedPassword(passwordRepeat: UITextField, view: UIView) {
        NSLayoutConstraint.activate([
            passwordRepeat.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordRepeat.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordRepeat.widthAnchor.constraint(equalToConstant: 250),
            passwordRepeat.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    static func setupRegistrationButton(button: UIButton, passwordRepeat: UITextField) {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: passwordRepeat.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: passwordRepeat.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    //MARK: - Login View
    static func setupLoginTitle(label: UILabel, view: UIView) {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.widthAnchor.constraint(equalToConstant: 130),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    static func setupLoginPassword(password: UITextField, view: UIView) {
        NSLayoutConstraint.activate([
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            password.widthAnchor.constraint(equalToConstant: 220),
            password.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    static func setupLoginButton(button: UIButton, password: UITextField, view: UIView) {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: password.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 90),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    //MARK: - User Information View
    static func setupScrollViewConstraints(scrollView: UIScrollView, view: UIView) {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    static func setupAccountLabelConstraints(label: UILabel, background: UILabel, iban: UILabel, amount: UILabel, currency: UILabel) {
        NSLayoutConstraint.activate([
            // BACKGROUND
            background.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 15),
            background.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -15),
            background.topAnchor.constraint(equalTo: label.topAnchor, constant: 20),
            background.heightAnchor.constraint(equalToConstant: 125),
            
            // IBAN
            iban.topAnchor.constraint(equalTo: background.topAnchor, constant: 20),
            iban.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20),
            
            // AMOUNT
            amount.leadingAnchor.constraint(equalTo: iban.leadingAnchor),
            amount.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20),
            amount.topAnchor.constraint(equalTo: iban.bottomAnchor, constant: 10),
            
            // CURRENCY
            currency.leadingAnchor.constraint(equalTo: amount.leadingAnchor),
            currency.trailingAnchor.constraint(equalTo: amount.trailingAnchor),
            currency.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: 10)
        ])
    }
    
    static func setupTransactionTitleConstraints(transaction: UILabel, view: UIView, scrollView: UIScrollView) {
        NSLayoutConstraint.activate([
            transaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            transaction.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
        ])
    }
    
    static func setupTableViewConstraints(tableView: UITableView, view: UIView, transaction: UILabel) {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: transaction.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}

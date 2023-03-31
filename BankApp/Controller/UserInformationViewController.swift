//
//  UserInformationViewController.swift
//  BankApp
//
//  Created by David Klaric on 23.02.2023..
//

import UIKit

protocol UserInformationViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class UserInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    weak var delegate: UserInformationViewControllerDelegate?
    
    var viewModel = AccountsViewModel()
    var data: DataModel?
    var currentLabelIndex = 0
    
    // MARK: - Labels
    let transaction = UILabel()
    let tableView = UITableView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        viewModel.getData { [weak self] in
            self?.data = self?.viewModel.dataModel
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        setupNavigationBar()
        setupAccountInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScrollView()
    }
    
    // MARK: - UI Setup Functions
    func setupNavigationBar() {
        title = "User Informationt"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(didTapMenuButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.tintColor = UIColor.systemYellow
    }
    
    func setupAccountInfo() {
        setupScrollView()
        setupTransactions()
    }
    
    func setupTransactions() {
        setupTransactionTitle()
        setupTableView()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 160),
        ])
        
        viewModel.getData {
            guard let accounts = self.data?.acounts else { return }
            if (accounts.isEmpty) { return }
            self.scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(accounts.count), height: 150)
            self.scrollView.isPagingEnabled = true
            
            // create label for each account
            for (i, account) in accounts.enumerated() {
                let label = self.setupText(account: account)
                label.frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: 150)
                label.font = UIFont.systemFont(ofSize: 20)
                label.textAlignment = .center
                self.scrollView.addSubview(label)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        
        if currentPage != currentLabelIndex {
            currentLabelIndex = currentPage
            tableView.reloadData()
        }
    }
    
    func setupText(account: Acount) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        
        let background = UILabel()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .systemYellow
        background.layer.cornerRadius = 25
        background.layer.masksToBounds = true
        label.addSubview(background)
        
        let iban = UILabel()
        iban.translatesAutoresizingMaskIntoConstraints = false
        iban.font = UIFont.systemFont(ofSize: 18)
        iban.text = "IBAN: \(account.IBAN)"
        label.addSubview(iban)
        
        let amount = UILabel()
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.font = UIFont.systemFont(ofSize: 18)
        amount.text = "Amount: \(account.amount)"
        label.addSubview(amount)
        
        let currency = UILabel()
        currency.translatesAutoresizingMaskIntoConstraints = false
        currency.font = UIFont.systemFont(ofSize: 18)
        currency.text = "Currency: \(account.currency)"
        label.addSubview(currency)
        
        
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
        
        return label
    }
    
    func setupTransactionTitle() {
        view.addSubview(transaction)
        
        transaction.translatesAutoresizingMaskIntoConstraints = false
        transaction.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        transaction.text = "Transactions"
        
        NSLayoutConstraint.activate([
            transaction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transaction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            transaction.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: transaction.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.acounts[currentLabelIndex].transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        let transaction = data?.acounts[currentLabelIndex].transactions[indexPath.row]
        
        cell.dateLabel.text = transaction?.date
        cell.descriptionLabel.text = transaction?.description
        cell.amountLabel.text = transaction?.amount
        cell.typeLabel.text = transaction?.type
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // MARK: - Objective C
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}

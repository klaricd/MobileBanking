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
    let myScrollView = UIScrollView()
    
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
        myScrollView.delegate = self
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myScrollView)
        
        Constraints.setupScrollViewConstraints(scrollView: myScrollView, view: view)
        
        viewModel.getData {
            guard let accounts = self.data?.acounts else { return }
            if (accounts.isEmpty) { return }
            self.myScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(accounts.count), height: 150)
            self.myScrollView.isPagingEnabled = true
            
            // create label for each account
            for (i, account) in accounts.enumerated() {
                let label = self.setupText(account: account)
                label.frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: 150)
                label.font = UIFont.systemFont(ofSize: 20)
                label.textAlignment = .center
                self.myScrollView.addSubview(label)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == myScrollView {
            let pageWidth = scrollView.frame.width
            let currentPage = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
            
            if currentPage != currentLabelIndex {
                currentLabelIndex = currentPage
                print(currentLabelIndex)
                tableView.reloadData()
            }
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
        
        Constraints.setupAccountLabelConstraints(label: label, background: background, iban: iban, amount: amount, currency: currency)
        
        return label
    }
    
    func setupTransactionTitle() {
        view.addSubview(transaction)
        
        transaction.translatesAutoresizingMaskIntoConstraints = false
        transaction.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        transaction.text = "Transactions"
        
        Constraints.setupTransactionTitleConstraints(transaction: transaction, view: view, scrollView: myScrollView)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        Constraints.setupTableViewConstraints(tableView: tableView, view: view, transaction: transaction)
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
        cell.selectionStyle = .none
        
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

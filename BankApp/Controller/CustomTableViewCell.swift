//
//  CustomTableViewCell.swift
//  BankApp
//
//  Created by David Klaric on 27.02.2023..
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "25.01.2016"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Uplata 1"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "50,00 HRK"
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "GSM VOUCHER"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(typeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(x: 10, y: -20, width: 130, height: contentView.frame.size.height - 10)
        amountLabel.frame = CGRect(x: 10, y: 20, width: 130, height: contentView.frame.size.height - 10)
        descriptionLabel.frame = CGRect(x: 200, y: -20, width: 100, height: contentView.frame.size.height - 10)
        typeLabel.frame = CGRect(x: 200, y: 20, width: 150, height: contentView.frame.size.height - 10)
    }
}

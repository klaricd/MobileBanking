//
//  UserInfoModel.swift
//  BankApp
//
//  Created by David Klaric on 23.02.2023..
//

import Foundation

struct DataModel: Codable {
    let user_id: String
    let acounts: [Acount]
}

struct Acount: Codable {
    let id: String
    let IBAN: String
    let amount: String
    let currency: String
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: String
    let date: String
    let description: String
    let amount: String
    let type: String?
}

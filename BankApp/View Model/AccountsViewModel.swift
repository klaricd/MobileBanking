//
//  AccountsViewModel.swift
//  BankApp
//
//  Created by David Klaric on 27.02.2023..
//

import Foundation

class AccountsViewModel {
    
    private var url = URL(string:"https://mportal.asseco-see.hr/builds/ISBD_public/Zadatak_1.json")!
    var dataModel: DataModel?
    
    func getData(completion: @escaping () ->() ) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let finalModel = try! JSONDecoder().decode(DataModel.self, from: data)
                self?.dataModel = finalModel
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
    }
}

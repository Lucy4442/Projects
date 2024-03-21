//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by mac on 21/03/24.
//

import Foundation

struct StatisticModel: Identifiable{
    
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentageChance : Double?
    
    init(title : String, value : String,percentageChance : Double? = nil)
    {
        self.title = title
        self.value = value
        self.percentageChance = percentageChance
    }
    
}


//
//  Appetizer.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import Foundation

struct Appetizer : Codable, Identifiable {
    
    let id : Int
    let name : String
    let description : String
    let price : Double
    let imageURL : String
    let calories : Int
    let protein : Int
    let carbs : Int
}


struct AppetizerResponse : Codable {
    
    let request : [Appetizer]
}


struct MockData {
    static let sampleAppetizer = Appetizer(id: 001,
                                           name: "Test",
                                           description: "This is test Description.This is test Description.",
                                           price: 9.99,
                                           imageURL: "",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    static let appetizers = [sampleAppetizer,sampleAppetizer,sampleAppetizer,sampleAppetizer]

    static let orderItem1 = Appetizer(id: 001,
                                           name: "Test 1",
                                           description: "This is test Description.This is test Description.",
                                           price: 9.99,
                                           imageURL: "",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItem2 = Appetizer(id: 002,
                                           name: "Test 2",
                                           description: "This is test Description.This is test Description.",
                                           price: 9.99,
                                           imageURL: "",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let orderItem3 = Appetizer(id: 003,
                                           name: "Test 3",
                                           description: "This is test Description.This is test Description.",
                                           price: 9.99,
                                           imageURL: "",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)

    static var orderItems = [orderItem1,orderItem2,orderItem3]
}

//
//  User.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import Foundation

struct User : Codable {
    var firstName       = ""
    var lastName        = ""
    var email           = ""
    var birthdate       = Date()
    var extraNapkins    = false
    var frequentRefills = false
}

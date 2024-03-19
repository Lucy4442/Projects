//
//  String+Ext.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import Foundation
import SwiftUI

extension String{
    var isValidEmail: Bool {
        let emailFormat     = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate   = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}








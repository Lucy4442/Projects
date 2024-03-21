//
//  UIApplication.swift
//  CryptoApp
//
//  Created by mac on 21/03/24.
//

import Foundation
import SwiftUI


extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

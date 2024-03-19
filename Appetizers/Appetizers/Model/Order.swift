//
//  Order.swift
//  Appetizers
//
//  Created by mac on 19/03/24.
//

import Foundation
import SwiftUI

final class Order : ObservableObject{
    
    @Published var items : [Appetizer] = []
    
    var TotalPrice : Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    
    func addItems(_ appetizer : Appetizer)
    {
        items.append(appetizer)
    }
    
    func deleteItems(at indexSet : IndexSet)
    {
        items.remove(atOffsets: indexSet)
    }
}

//
//  Date+Ext.swift
//  Appetizers
//
//  Created by mac on 19/03/24.
//

import Foundation

extension Date {
    
    var eighteenYearAgo : Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    
    var onehundredTenYearAgo : Date {
        Calendar.current.date(byAdding: .year, value: -110, to: Date())!
    }
}

//
//  ViewModel.swift
//  UnitTesting
//
//  Created by mac on 29/04/24.
//

import Foundation
import SwiftUI

class UnitTestingViewModel : ObservableObject {
    @Published var isPremium : Bool
    
    init(isPremium : Bool) {
        self.isPremium = isPremium
    }
    
}

//
//  UnitTestingView.swift
//  UnitTesting
//
//  Created by mac on 29/04/24.
//

import SwiftUI



struct UnitTestingView: View {
    
    @StateObject var vm : UnitTestingViewModel
    
    init(isPremium : Bool){
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingView(isPremium: true)
    }
}

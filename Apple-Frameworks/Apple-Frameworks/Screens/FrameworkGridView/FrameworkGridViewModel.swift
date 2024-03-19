//
//  FrameworkGridViewModel.swift
//  Apple-Frameworks
//
//  Created by mac on 15/03/24.
//
import SwiftUI

class FrameworkGridViewModel : ObservableObject{
    var selectedFramework : Framework?
    {
        didSet{
            isShowingFramework = true
        }
    }
    
    @Published var isShowingFramework : Bool = false
    
    
}

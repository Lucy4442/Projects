//
//  Color.swift
//  CryptoApp
//
//  Created by mac on 19/03/24.
//

import Foundation
import SwiftUI

struct ColorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

struct LunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}

extension Color {
    static let theme = ColorTheme()
    static let launch = LunchTheme()
}

//
//  CustomModifiers.swift
//  Appetizers
//
//  Created by mac on 19/03/24.
//

import SwiftUI


struct StanderdButtonStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.brandPrimary)
            .controlSize(.large)
    }
}

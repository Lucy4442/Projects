//
//  SettingsView.swift
//  FirebaseAuthentication
//
//  Created by mac on 08/05/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel : ObservableObject {
    func logOut() throws {
       try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSingInView : Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task {
                    do {
                        try viewModel.logOut()
                        showSingInView.toggle()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSingInView: .constant(true))
    }
}

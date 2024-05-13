//
//  RootView.swift
//  FirebaseAuthentication
//
//  Created by mac on 08/05/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView : Bool = false
    
    var body: some View {
        ZStack{
                SettingsView(showSingInView: $showSignInView)
        }
        .onAppear(perform: {
            let authUser = try?  AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        })
        .fullScreenCover(isPresented: $showSignInView){
            NavigationView{
                AuthenticationView()
            }
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RootView()
        }
    }
}

//
//  AuthenticationView.swift
//  FirebaseAuthentication
//
//  Created by mac on 08/05/24.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
            VStack{
                NavigationLink{
                    SignInEmailView()
                }label: {
                    Text("Sign In with Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        
                }
            }
            .padding()
            .navigationTitle("Sign In")
      
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthenticationView()
        }
    }
}

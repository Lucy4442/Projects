//
//  SignInEmailView.swift
//  FirebaseAuthentication
//
//  Created by mac on 08/05/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func SignIn() {
        guard !email.isEmpty,!password.isEmpty else {
            print("No email or password found.")
            return
        }
        Task{
            do{
                let returnedResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print(returnedResult)
            }
            catch {
                print("Error = \(error.localizedDescription)")
            }
        }
    }
    
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Email..", text: $viewModel.email)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .cornerRadius(10)
                
                SecureField("Password..", text: $viewModel.password)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .cornerRadius(10)
                
                Button{
                    viewModel.SignIn()
                }label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sign In With Email")
        }
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInEmailView()
    }
}

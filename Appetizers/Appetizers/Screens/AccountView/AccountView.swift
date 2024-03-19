//
//  AccountView.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    @FocusState var focusTextField : FormTextField?
    
    enum FormTextField {
        case firstName,lastName,email
    }

    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("First Name", text: $viewModel.user.firstName)
                        .focused($focusTextField, equals: .firstName)
                        .onSubmit { focusTextField = .lastName }
                        .submitLabel(.next)
                    
                    TextField("Last Name", text: $viewModel.user.lastName)
                        .focused($focusTextField, equals: .lastName)
                        .onSubmit { focusTextField = .email }
                        .submitLabel(.next)
                    
                    TextField("Email", text: $viewModel.user.email)
                        .focused($focusTextField, equals: .email)
                        .onSubmit { focusTextField = nil }
                        .submitLabel(.continue)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    DatePicker("Brithday", selection: $viewModel.user.birthdate, displayedComponents: .date)
                    
                    Button{
                        viewModel.saveChanges()
                    }label: {
                        Text("Save Changes")
                    }
                } header: {
                    Text("PESONAL INFO")
                }
                
                Section {
                    
                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                    Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
                    
                }header: {
                    Text("Requests")
                }
                .tint(.brandPrimary)
                
            }
            .navigationTitle("Account")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") {
                        focusTextField = nil
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.retriveUser()
        })
        .alert(viewModel.alertItem?.title ?? "Error", isPresented: viewModel.alertItem != nil ? .constant(true) : .constant(false)) {
            Button{
                viewModel.alertItem = nil
            }label: {
                viewModel.alertItem?.dissmissButton
            }
            
        } message: {
            viewModel.alertItem?.message
        }
    }
}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

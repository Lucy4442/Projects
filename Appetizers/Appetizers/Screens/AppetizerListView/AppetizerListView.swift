//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import SwiftUI

struct AppetizerListView: View {
    
    @StateObject var viewModel = AppetizerListViewModel()

    
    var body: some View {
        
        ZStack{
            
            NavigationView{
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
//                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            viewModel.selectedAppetizer = appetizer
                            viewModel.isShowingDetail = true
                        }
                    
                }
                .navigationTitle("🍎 Appetizer")
                .disabled(viewModel.isShowingDetail)
                .listStyle(.plain)
            }
            .onAppear {
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.isShowingDetail {
                AppetizerDetailView(appetizer: viewModel.selectedAppetizer!,
                                    isShowingDetail: $viewModel.isShowingDetail)
            }
            
        }
        .alert(viewModel.alertItem?.title ?? "Error", isPresented: viewModel.alertItem != nil ? .constant(true) : .constant(false)) {
            Button{
                
            }label: {
                viewModel.alertItem?.dissmissButton
            }
            
        } message: {
            viewModel.alertItem?.message
        }
    }
}


struct AppetizerListView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerListView()
    }
}

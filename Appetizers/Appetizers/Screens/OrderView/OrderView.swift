//
//  OrderView.swift
//  Appetizers
//
//  Created by mac on 18/03/24.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order : Order
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(order.items) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                        }
                        .onDelete(perform: order.deleteItems)
                    }
                    .listStyle(.plain)
                    
                    Button {
                        
                    } label: {
//                        APButton(title: "$\(order.TotalPrice,specifier: "%.2f") - Place Order")
                          Text("$\(order.TotalPrice,specifier: "%.2f") - Place Order")
                    }
                    .modifier(StanderdButtonStyle())
                    .padding(.bottom,25)
                }
                if order.items.isEmpty {
                    EmptyState(imageName: "empty-order",
                               message: "You have no items in your order. \nPlease add item!")
                }
            }
            .navigationTitle("🧾 Orders")
        }
        
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

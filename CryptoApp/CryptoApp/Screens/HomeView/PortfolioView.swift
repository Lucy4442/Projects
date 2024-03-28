//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by mac on 26/03/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @Binding var showPortfolioView : Bool
    
    @EnvironmentObject private var viewModel : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var quantityText : String = ""
    @State private var showCheckMark : Bool = false
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                //userPortfolioInsert view
                
                VStack(alignment: .leading, spacing: 0)
                {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        VStack(spacing : 20)
                        {
                            HStack{
                                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                                Spacer()
                                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                            }
                            Divider()
                            
                            HStack{
                                Text("Amount holding:")
                                Spacer()
                                TextField("Ex. 1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            
                            HStack{
                                Text("Current Value")
                                Spacer()
                                Text(getCurrentValue().asCurrencyWith2Decimals())
                            }
                        }
                        .padding()
                        .animation(.none)
                    }
                    
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showPortfolioView = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .opacity(showCheckMark ? 1 : 0)
                            .foregroundColor(Color.theme.accent)
                        
                        Button {
                            saveButtonPressed()
                        } label: {
                            Text("SAVE")
                        }
                        .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1: 0)

                    }
                }
            }
            .onChange(of: viewModel.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showPortfolioView: .constant(true))
    }
}



extension PortfolioView {
    
    private var coinLogoList : some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing : 10){
                ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins:viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn)
                            {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding()
        }
    }
    
    private func updateSelectedCoin(coin : CoinModel)
    {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }), let amount = portfolioCoin.currentHoldings{
            quantityText = "\(amount)"
        }
        else{
            quantityText = ""
        }
       
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
                else { return }
        
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn)
        {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            withAnimation(.easeOut)
            {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
       selectedCoin = nil
        viewModel.searchText = ""
    }
}

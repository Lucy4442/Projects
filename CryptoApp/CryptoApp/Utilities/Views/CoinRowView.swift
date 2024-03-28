//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by mac on 20/03/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    var showHoldingColumn : Bool
    
    var body: some View {
        HStack(alignment : .center){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            
            Text(coin.symbol.uppercased())
                .foregroundColor(Color.theme.accent)
                .padding(.leading,6)
            
            Spacer()
            
            if showHoldingColumn {
                VStack(alignment : .trailing)
                {
                    Text("$\(coin.currentHoldingsValue,specifier: "%.2f")")
                        .bold()
                    Text("\(coin.currentHoldings ?? 0,specifier: "%.2f")")
                }
                .foregroundColor(Color.theme.accent)
            }
            
            
            VStack(alignment : .trailing){
                Text("$\(coin.currentPrice,specifier: "%.2f")")
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                Text("\(coin.priceChangePercentage24H ?? 0,specifier: "%.2f")%")
                    .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.red)
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            
        }
        .font(.subheadline)
        .background(Color.theme.background.opacity(0.001))
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                        .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                        .previewLayout(.sizeThatFits)
                        .preferredColorScheme(.dark)
        }
       
    }
}

//
//  HomeView.swift
//  CryptoApp
//
//  Created by mac on 19/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel : HomeViewModel
    @State private var showPortfolio : Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $viewModel.searchText)
                
                columnTitle

                if !showPortfolio{
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    portfolioCoinList
                    .transition(.move(edge: .trailing))
                }
                Spacer()
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewModel())
    }
}

extension HomeView {
  private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background( CircleButtonAnimationView(animate: $showPortfolio) )
                .animation(.none, value: showPortfolio)
            Spacer()
            Text( showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring(dampingFraction : 0.6))
                    {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
}

extension HomeView {
    private var columnTitle : some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

extension HomeView {
    private var allCoinList : some View {
        List
        {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}


extension HomeView {
    private var portfolioCoinList : some View {
        List
        {
            ForEach(viewModel.portfiloCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
}


struct HomeStatsView : View {
    
    @EnvironmentObject private var viewModel : HomeViewModel
    @Binding var showPortfolio : Bool
    
    var body : some View {
        HStack{
            ForEach(viewModel.statistic) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(HomeViewModel())
    }
}

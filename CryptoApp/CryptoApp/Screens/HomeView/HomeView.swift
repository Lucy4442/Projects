//
//  HomeView.swift
//  CryptoApp
//
//  Created by mac on 19/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel : HomeViewModel
    @State private var showPortfolio : Bool = false // animate right
    @State private var showPortfolioView : Bool = false // new sheet
    @State private var showSettingsView : Bool = false
    @State private var showDetailView : Bool = false
    @State private var selectedCoin : CoinModel? = nil
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView(showPortfolioView: $showPortfolioView)
                        .environmentObject(viewModel)
                }
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
            .sheet(isPresented: $showSettingsView) {
                SettingsView(showSettingsView: $showSettingsView)
            }
            
        }
        .background(
            NavigationLink(isActive: $showDetailView, destination: {
                DetailViewLoading(coin: $selectedCoin)
            }, label: {
                EmptyView()
            })
        )
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
                .onTapGesture {
                    if showPortfolio{
                        showPortfolioView.toggle()
                    }
                    else {
                        showSettingsView.toggle()
                    }
                }
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
            HStack(spacing : 4)
            {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1:0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default)
                {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio{
                HStack(spacing : 4)
                {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingReversed) ? 1:0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default)
                    {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingReversed : .holdings
                    }
                }
            }
            
            HStack(spacing : 4)
            {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1:0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            .onTapGesture {
                withAnimation(.default)
                {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            
            Button {
                withAnimation(.linear(duration: 2))
                {
                    viewModel.reload()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0),anchor: .center)

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
                        .onTapGesture {
                            segue(coin: coin)
                        }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(coin : CoinModel)
    {
        selectedCoin = coin
        showDetailView.toggle()
    }
}


extension HomeView {
    private var portfolioCoinList : some View {
        List
        {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
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

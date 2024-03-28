//
//  DetailView.swift
//  CryptoApp
//
//  Created by mac on 27/03/24.
//

import SwiftUI

struct DetailViewLoading : View {
    
    @Binding var coin : CoinModel?
    
    var body: some View{
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
    
}


struct DetailView: View {
    
    @StateObject var viewModel : DetailViewModel
    @State private var showFullDescription : Bool = false
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing : CGFloat = 30
    
    init(coin : CoinModel)
    {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                
                VStack(spacing : 20){
                    
                    overviewTitle
                    
                    Divider()
                    
                    descriptionView
                    
                    overviewGrid
                    
                    additionalTitle
                    
                    Divider()
                    
                    additionalGrid
                    
                    websiteSectionView
                    
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBartrailingItem
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin : dev.coin)
        }
        .preferredColorScheme(.dark)
    }
}


extension DetailView {
    
    private var overviewTitle : some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var additionalTitle : some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var overviewGrid : some View{
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            
            ForEach(viewModel.overviewStatistics){ stat in
                StatisticView(stat: stat)
            }
            
        }
    }
    
    private var additionalGrid : some View{
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            
            ForEach(viewModel.additionalStatistics){ stat in
                StatisticView(stat: stat)
            }
            
        }
    }
    
    private var navigationBartrailingItem: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var descriptionView: some View {
         ZStack{
             if let coinDescription = viewModel.coinDescription,
                !coinDescription.isEmpty {
                 VStack(alignment : .leading) {
                     Text(coinDescription)
                         .font(.callout)
                         .foregroundColor(Color.theme.secondaryText)
                         .lineLimit(showFullDescription ? nil : 3)
                     Button {
                         withAnimation(.easeInOut)
                         {
                             showFullDescription.toggle()
                         }
                     } label: {
                         Text(showFullDescription ? "Less" : "Read more..")
                             .font(.caption)
                             .bold()
                             .padding(.vertical,4)
                     }
                     .accentColor(.blue)
                     
                 }
             }
         }
     }
    
    private var websiteSectionView : some View {
        VStack(alignment: .leading, spacing: 20){
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString){
                Link("Website", destination: url)
            }
            
            if let redditString = viewModel.reditURL,
               let url = URL(string: redditString){
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth : .infinity,alignment: .leading)
        .font(.headline)
    }
}

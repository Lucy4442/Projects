//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by mac on 20/03/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistic : [StatisticModel] = []
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfiloCoins : [CoinModel] = []
    @Published var searchText : String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    private var cancelable = Set<AnyCancellable>()
    init()
    {
        addSubscriber()
    }
    
    func addSubscriber(){
        
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text,statingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return statingCoins
                }
                
                let lowercasedText = text.lowercased()
                
                return statingCoins.filter { (coin) -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
                }
                
            }
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelable)
        
        marketDataService.$marketData
            .map { (MarketDataModel) -> [StatisticModel] in
                var stats : [StatisticModel] = []
                
                guard let data = MarketDataModel else {
                    return stats
                }
                
                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChance: data.marketCapChangePercentage24HUsd)
                
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                
                let btcDomimance = StatisticModel(title: "BTC Domimance", value: data.btcDominance)
                
                let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChance: 0)
                
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDomimance,portfolio
                ])
                
                return stats
            }
            .sink { [weak self] (returnedStats) in
                self?.statistic = returnedStats
            }
            .store(in: &cancelable)
    }
}

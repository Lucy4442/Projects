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
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var isLoading : Bool = false
    @Published var sortOption : SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancelable = Set<AnyCancellable>()
    
    enum SortOption {
        case rank ,rankReversed ,holdings ,holdingReversed ,price ,priceReversed
    }
    
    
    init()
    {
        addSubscriber()
    }
    
    func addSubscriber()
    {
        
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoin)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelable)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map{(coinModels,portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: { $0.coinId == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
                
            }
            .sink {[weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancelable)
        
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map { (MarketDataModel : MarketDataModel?, portfolioCoins : [CoinModel]) -> [StatisticModel] in
                var stats : [StatisticModel] = []
                
                guard let data = MarketDataModel else {
                    return stats
                }
                
                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChance: data.marketCapChangePercentage24HUsd)
                
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                
                let btcDomimance = StatisticModel(title: "BTC Domimance", value: data.btcDominance)
                
                
                let portfolioValue =
                portfolioCoins
                    .map { $0.currentHoldingsValue }
                    .reduce(0,+)
                
                let previousValue =
                portfolioCoins
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingsValue
                        let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
                    }
                    .reduce(0,+)
                
                let change = (portfolioValue - previousValue) / previousValue
                
                let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChance: change)
                
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDomimance,portfolio
                ])
                
                return stats
            }
            .sink { [weak self] (returnedStats) in
                self?.statistic = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancelable)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double)
    {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reload()
    {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        
    }
    
    private func filterAndSortCoin(text: String, startingCoins: [CoinModel], sort: SortOption) -> [CoinModel]{
        var updatedCoins = filterCoins(text: text, startingCoins: startingCoins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    
    private func filterCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel]
    {
        guard !text.isEmpty else{
            return startingCoins
        }
        let lowerCasedText = text.lowercased()
        return startingCoins.filter { coin in
            return coin.name.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText) ||
            coin.symbol.contains(lowerCasedText)
        }
    }
    
    func sortCoins(sort : SortOption,coins : inout [CoinModel])
    {
        switch sort {
        case .rank,.holdings:
            coins.sort { $0.rank < $1.rank}
        case .rankReversed,.holdingReversed:
            coins.sort { $0.rank > $1.rank}
        case .price:
            coins.sort { $0.currentPrice > $1.currentPrice}
        case .priceReversed:
            coins.sort { $0.currentPrice < $1.currentPrice}
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins : [CoinModel]) -> [CoinModel]
    {
        switch sortOption {
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
    }
}

//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by mac on 28/03/24.
//

import Foundation
import UIKit
import Combine

class DetailViewModel : ObservableObject{
    
    @Published var overviewStatistics : [StatisticModel] = []
    @Published var additionalStatistics : [StatisticModel] = []
    @Published var coin : CoinModel
    @Published var coinDescription : String? = nil
    @Published var websiteURL : String? = nil
    @Published var reditURL : String? = nil
    
    private let coinDetailService : CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coin : CoinModel)
    {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map (mapDataToStatistics)
            .sink(receiveValue: { (returnedArrays) in
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            })
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink {[weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.reditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    
    private func mapDataToStatistics(coinDetailModel : CoinDetailModel?, coinModel : CoinModel) -> (overview : [StatisticModel], additional : [StatisticModel]) {
        
        //overview
        
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChance: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChance: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray : [StatisticModel] = [priceStat,marketCapStat,rankStat,volumeStat]
        
        //Additional
        
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange,percentageChance: pricePercentChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "n/a")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h market Cap Change", value: marketCapChange, percentageChance: marketCapPercentChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        
        let additionalArray : [StatisticModel] = [highStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat]
        
        return (overviewArray,additionalArray)
    }
}

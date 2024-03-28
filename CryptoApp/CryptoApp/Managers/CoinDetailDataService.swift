//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by mac on 28/03/24.
//

import Foundation
import Combine


class CoinDetailDataService {
    
    @Published var coinDetails : CoinDetailModel? = nil
    var coinDetailSubscription : AnyCancellable?
    let coin : CoinModel
    
    init(coin : CoinModel){
        self.coin = coin
        getCoinsDetails()
    }
    
// URL: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
    
    func getCoinsDetails()
    {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnCoinDetails) in
                self?.coinDetails = returnCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}

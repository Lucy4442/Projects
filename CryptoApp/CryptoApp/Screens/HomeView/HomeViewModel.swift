//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by mac on 20/03/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfiloCoins : [CoinModel] = []
    @Published var searchText : String = ""
    
    private let networkManager = CoinDataService()
    private var cancelable = Set<AnyCancellable>()
    init()
    {
        addSubscriber()
    }
    
    func addSubscriber(){
        networkManager.$allCoins
            .sink { [weak self] returnedCoin in
                self?.allCoins = returnedCoin
            }
            .store(in: &cancelable)
        
        $searchText
            .combineLatest(networkManager.$allCoins)
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

    }
}

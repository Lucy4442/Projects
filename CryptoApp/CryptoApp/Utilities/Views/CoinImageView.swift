//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by mac on 21/03/24.
//

import SwiftUI
import Combine


class CoinImageViewModel : ObservableObject{
    
    @Published var image : UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin : CoinModel
    private let dataService : CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin : CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        getImage()
        self.isLoading = true
    }
    
    private func getImage(){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
}



struct CoinImageView: View {
    
    @StateObject var viewModel : CoinImageViewModel
    
    init(coin : CoinModel)
    {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if viewModel.isLoading {
            ProgressView()
        }
        else{
            Image(systemName: "questionmark")
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

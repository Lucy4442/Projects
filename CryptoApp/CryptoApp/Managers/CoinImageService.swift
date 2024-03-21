//
//  CoimImageService.swift
//  CryptoApp
//
//  Created by mac on 21/03/24.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService{
    
    @Published var image : UIImage? = nil
    private var imageSubscription : AnyCancellable?
    private let coin : CoinModel
    private let filManager = LocalFileManager.instance
    private let folderName = "coins_image"
    private let imageName : String
    
    init(coin : CoinModel)
    {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        
        if let savedImage = filManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
//            print("Retrive Image Successfully")
        }
        else{
            downloadCoinImage()
//            print("Downloading Image")
        }
        
    }
    
    private func downloadCoinImage()
    {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.filManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}

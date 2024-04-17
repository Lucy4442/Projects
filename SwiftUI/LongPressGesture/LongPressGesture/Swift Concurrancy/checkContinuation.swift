//
//  checkContinuation.swift
//  LongPressGesture
//
//  Created by mac on 08/04/24.
//

import SwiftUI
import AVFoundation

class NetworkManager {
    
    func getData(url : URL) async throws -> Data {
        
        do {
           let (data,_) = try await URLSession.shared.data(from: url, delegate: nil)
            return data
        } catch {
            throw error
        }
        
    }
    
    func getData2(url : URL) async throws -> Data {
       
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                }else {
                    continuation.resume(throwing: URLError(.badURL))
                }
                
            }.resume()
        }
    }
    
}

class ContinuatiobViewModel : ObservableObject {
    
    @Published var image : UIImage? = nil
    let networkManager = NetworkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        
        do {
           let data = try await networkManager.getData2(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch {
            print(error)
        }
        
    }
}

struct checkContinuation: View {
    
    @StateObject private var viewModel = ContinuatiobViewModel()
    
    var body: some View {
        ZStack{
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable().scaledToFit()
                    .frame(width : 200,height : 200)
            }
        }
        .task {
            await viewModel.getImage()
        }
    }
}

struct checkContinuation_Previews: PreviewProvider {
    static var previews: some View {
        checkContinuation()
    }
}

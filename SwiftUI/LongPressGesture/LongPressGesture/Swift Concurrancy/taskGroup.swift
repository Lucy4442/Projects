//
//  taskGroup.swift
//  LongPressGesture
//
//  Created by mac on 08/04/24.
//

import SwiftUI

struct taskGroup: View {
    
    @StateObject private var vm = TaskGroupViewModel()
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images,id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height : 150)
                    }
                }
            }
            .navigationTitle("Task Group 😃")
            .task {
                await vm.getImages()
            }
        }
    }
}

class TaskGroupViewModel : ObservableObject {
    @Published var images : [UIImage] = []
    let manager = DataManager()
    
    func getImages() async {
        
        if let images = try? await manager.fetchImageWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
        
    }
    
}

class DataManager : ObservableObject {
    
    let url : String = "https://picsum.photos/200"
    
    //Use of Async Let
    
    func fetchImageWithAsyncLet() async throws -> [UIImage] {
        
        async let fetchImage1 = fetchImage(urlString: url)
        async let fetchImage2 = fetchImage(urlString: url)
        async let fetchImage3 = fetchImage(urlString: url)
        async let fetchImage4 = fetchImage(urlString: url)
        
        let (image1,image2,image3,image4) = await (try fetchImage1,try fetchImage2,try fetchImage3,try fetchImage4)
        
        return [image1,image2,image3,image4]
    }
    
    //Use of TaskGroup
    
    func fetchImageWithTaskGroup() async throws -> [UIImage] {
        
        let urlStrings = [url,url,url,url]
        
        return try await withThrowingTaskGroup(of: UIImage?.self){ group in
            var images : [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask{
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            return images
        }
    }
    
    private func fetchImage(urlString : String) async throws ->UIImage {
        guard let url = URL(string : urlString) else { throw URLError(.badURL) }
        
        do {
            let (data,_) = try await  URLSession.shared.data(from : url , delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        }catch {
            throw error
        }
    }
    
}

struct taskGroup_Previews: PreviewProvider {
    static var previews: some View {
        taskGroup()
    }
}

//
//  ContentView.swift
//  DependencyInjection
//
//  Created by mac on 29/04/24.
//

import SwiftUI
import Combine

//PROBLEM WITH SINGLTON
//1. Singleton's are GLOBAL
//2. Can't customize the init!
//3. Can't swap our services


struct PostModel: Codable,Identifiable {
//    "userId": 1,
//        "id": 1,
//        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    
    let userId : Int
    let id : Int
    let title : String
    let body : String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}

class ProductionDataService : DataServiceProtocol{
    
    let url : URL
    
    init(url : URL){
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

class MockDataService : DataServiceProtocol{
    
    let testData : [PostModel]
    
    init(data : [PostModel]?)
    {
        self.testData = data ?? [PostModel(userId: 1, id: 1, title: "One", body: "one")]
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        Just(testData)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
    
}

class DependenctInjectionViewModel : ObservableObject {
    @Published var dataArray : [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService : DataServiceProtocol
    
    init(dataService : DataServiceProtocol){
        self.dataService = dataService
        loadPost()
    }
    
    func loadPost(){
       dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
    
}


struct ContentView: View {
    
    @StateObject var vm : DependenctInjectionViewModel
    
    init(dataService : DataServiceProtocol){
       _vm = StateObject(wrappedValue: DependenctInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(vm.dataArray) {post in
                    Text(post.title)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
//    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    static let dataService = MockDataService(data: nil)
    static var previews: some View {
        ContentView(dataService: dataService)
    }
}

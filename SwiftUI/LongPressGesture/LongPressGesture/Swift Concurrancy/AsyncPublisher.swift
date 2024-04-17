//
//  AsyncPublisher.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI
import Combine

class AsyncPublisherDataManager {
    
    @Published var myData : [String] = []
    
    func addData() async{
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Kivi")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Watermelon")
    }
}

class AsyncPublisherViewModel : ObservableObject {
    @Published var dataArray : [String] = []
    let manager = AsyncPublisherDataManager()
    var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
    }
    
    private func addSubscriber()
    {
        Task{
            for await value in manager.$myData.values {
                await MainActor.run(body: {
                    self.dataArray = value
                })
            }
        }
        
//        manager.$myData
//            .receive(on: DispatchQueue.main, options: nil)
//            .sink { dataArray in
//                self.dataArray = dataArray
//            }
//            .store(in: &cancellables)
    }
    
    func start() async {
        await manager.addData()
    }
}

struct AsyncPublisher: View {
    
    @StateObject var viewModel = AsyncPublisherViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.start()
        }
    }
    
}

struct AsyncPublisher_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisher()
    }
}

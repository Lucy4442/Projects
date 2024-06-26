//
//  AsyncStream.swift
//  LongPressGesture
//
//  Created by mac on 09/04/24.
//

import SwiftUI

class AsyncStreamDataManager {
    
    func getAsyncStream() -> AsyncThrowingStream<Int,Error> {
        AsyncThrowingStream{ [weak self] continuation in
            self?.getFakeData(newValue: { value in
                continuation.yield(value)
            }, onFinish: {error in
                continuation.finish(throwing: error)
            })
        }
    }

    
    func getFakeData(newValue : @escaping (_ value : Int) -> Void,
                     onFinish : @escaping (_ error : Error?) -> Void) {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item)) {
                newValue(item)
                print("NEW DATA: \(item)")
                if item == items.last {
                    onFinish(nil)
                }
            }
        }
    }
}

@MainActor
final class AsyncStreamViewModel : ObservableObject {
    
    @Published private(set) var currentNumber : Int = 0
    let manager = AsyncStreamDataManager()
    
    func onAppear(){
//        manager.getFakeData{ [weak self] value in
//            self?.currentNumber = value
//        }
       let task = Task {
            do {
                for try await value in manager.getAsyncStream() {
                    currentNumber = value
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            task.cancel()
            print("TASK CANCELLED!!!")
        }
    }
    
}

struct AsyncStream : View {
    
    @StateObject var viewModel = AsyncStreamViewModel()
    
    var body: some View{
        Text("\(viewModel.currentNumber)")
            .onAppear {
                viewModel.onAppear()
            }
    }
}

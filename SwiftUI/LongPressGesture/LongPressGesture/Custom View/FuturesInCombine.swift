//
//  FuturesInCombine.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import SwiftUI
import Combine

class FuturesViewModel : ObservableObject {
    
    @Published var title : String = "Starting Title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()
    init() {
        download()
    }
    
    func download(){
//        getCombinePublisher()
//            .sink { _ in
//
//            } receiveValue: { [weak self] returnedValue in
//                self?.title = returnedValue
//            }
//            .store(in: &cancellables)
        
//        getEscapingclosure {[weak self] returnedValue, error in
//            self?.title = returnedValue
//        }

        
        getFuturePublisher()
            .sink { _ in
           
                       } receiveValue: { [weak self] returnedValue in
                           self?.title = returnedValue
                       }
                       .store(in: &cancellables)
        
    }
    
    func getCombinePublisher() -> AnyPublisher<String,URLError>  {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
        
    }
    
    func getEscapingclosure(completionHandler : @escaping (_ value : String, _ error : Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("New Value 2", nil)
        }.resume()
    }
    
    func getFuturePublisher() -> Future<String , Error > {
        return Future { [self] promise in
            getEscapingclosure { value, error in
                if let error = error {
                    promise(.failure(error))
                }
                else {
                    promise(.success(value))
                }
            }
        }
    }
}

struct FuturesInCombine: View {
    
    @StateObject var vm = FuturesViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

struct FuturesInCombine_Previews: PreviewProvider {
    static var previews: some View {
        FuturesInCombine()
    }
}

//
//  MultiThreading.swift
//  LongPressGesture
//
//  Created by mac on 04/04/24.
//

import SwiftUI

class BackgroundThreadViewModel : ObservableObject{
    
    @Published var dataArray : [String] = []
    
    func fetchData(){
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
        
    }
    
    func downloadData() -> [String]{
        var data : [String] = []
        for x in 0..<1000 {
            data.append("\(x)")
            print("\(x)")
        }
        return data
    }
}

struct MultiThreading: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack{
                Text("LOAD DATA")
                .font(.system(size: 30))
                .bold()
                .onTapGesture {
                    vm.fetchData()
                }
                
                ForEach(vm.dataArray,id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            Spacer()
                
            }
        }
    }
}

struct MultiThreading_Previews: PreviewProvider {
    static var previews: some View {
        MultiThreading()
    }
}

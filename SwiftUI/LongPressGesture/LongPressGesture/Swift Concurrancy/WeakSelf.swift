//
//  WeakSelf.swift
//  LongPressGesture
//
//  Created by mac on 04/04/24.
//

import SwiftUI

struct WeakSelf: View {
    
    @AppStorage("count") var count : Int?
    
    init()
    {
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
            .navigationTitle("Screen 1")
        }
        .overlay(
        Text("\(count ?? 0)")
            .font(.largeTitle)
            .padding()
            .background(Color.green.cornerRadius(10))
        ,alignment: .topTrailing)
    }
}

struct WeakSelfSecondScreen: View {
    @StateObject var vm = WeakSelfViewModel()
    var body: some View {

        VStack{
            Text("Secound View")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
        
    }
}

class WeakSelfViewModel : ObservableObject {
    
    @Published var data : String? = nil
    
    init(){
        print("INIT NOW")
        
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        
        getData()
    }
    
    deinit{
        print("DEINIT NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData(){
        DispatchQueue.main.asyncAfter(deadline : .now() + 5) { [weak self] in
            self?.data = "NEW DATA"
        }
    }
    
}

struct WeakSelf_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelf()
    }
}

//
//  Actor.swift
//  LongPressGesture
//
//  Created by mac on 08/04/24.
//

import SwiftUI

class MyDataManager {
    
    static let instance = MyDataManager()
    private init() {}
    
    var data : [String] = []
    let queue = DispatchQueue(label: "com.unikwork.Actor")
    
    func getRandomData(completionHandler : @escaping (_ title : String?) -> ()) {
        queue.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
      
    }
}

actor MyActorDataManager {
    
    static let instance = MyActorDataManager()
    private init() {}
    
    var data : [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
      
    }
}

struct HomeView : View {
    
    let manager = MyActorDataManager.instance
    let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    @State private var text : String = ""
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task{
                if  let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
                
            }
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct BrowserView : View {
    
    let manager = MyActorDataManager.instance
    let timer = Timer.publish(every: 0.01, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    @State private var text : String = ""
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task{
                if  let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
                
            }
//            DispatchQueue.global(qos: .default).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct Actor: View {
    
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home",systemImage: "house.fill")
                }
            
            BrowserView()
                .tabItem {
                    Label("Browse",systemImage: "magnifyingglass")
                }
        }
    }
}

struct Actor_Previews: PreviewProvider {
    static var previews: some View {
        Actor()
    }
}

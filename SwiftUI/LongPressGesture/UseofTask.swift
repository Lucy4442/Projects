//
//  UseofTask.swift
//  LongPressGesture
//
//  Created by mac on 08/04/24.
//

import SwiftUI

class ViewModel : ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var image2 : UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data,_) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                print("IMAGE RETURNED SUCCESSFULLY")
            })
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data,_) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
                print("IMAGE RETURNED SUCCESSFULLY")
            })
        }catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskView : View {
    var body: some View {
        
        NavigationView{
            ZStack{
                NavigationLink("CLICK ME 😀") {
                    UseofTask()
                }
            }
        }
    }
}

struct UseofTask: View {
    
    @StateObject private var vm = ViewModel()
    @State private var fetchImageTask : Task<(),Never>? = nil
    
    var body: some View {
        VStack(spacing : 40)
        {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width : 200, height: 200)
            }
            
            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width : 200, height: 200)
            }
        }
        .task {
            await vm.fetchImage()
        }
//        .onDisappear(perform: {
//            fetchImageTask?.cancel()
//        })
//        .onAppear {
//            fetchImageTask = Task {
//                await vm.fetchImage()
//            }
//
//            Task {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await vm.fetchImage2()
//            }
            
//            Task(priority: .high) {
//              try? await Task.sleep(nanoseconds: 2_000_000_000)
//                await Task.yield()
//                print("high : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .userInitiated) {
//                print("userInitiated : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .medium) {
//                print("medium : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .low) {
//                print("low : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .utility) {
//                print("utility : \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .background) {
//                print("background : \(Thread.current) : \(Task.currentPriority)")
//            }
            
//            Task(priority: .userInitiated) {
//                print("userInitiated : \(Thread.current) : \(Task.currentPriority)")
//
//                Task.detached {
//                    print("userInitiated2 : \(Thread.current) : \(Task.currentPriority)")
//                }
//            }
            
          
        }
    }


struct UseofTask_Previews: PreviewProvider {
    static var previews: some View {
        UseofTask()
    }
}

//
//  Timer.swift
//  LongPressGesture
//
//  Created by mac on 04/04/24.
//

import SwiftUI

struct TimerOnReceive: View {
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
//    @State var timeRemaining : String = ""
//    let futureDate : Date = Calendar.current.date(byAdding: .minute, value: 2, to: Date()) ?? Date()
//
//    func updateTimeRemaining(){
//        let remaining = Calendar.current.dateComponents([.hour,.minute,.second], from: Date(), to: futureDate)
//        let hours = remaining.hour ?? 0
//        let minute = remaining.minute ?? 0
//        let second = remaining.second ?? 0
//
//        timeRemaining = "\(hours):\(minute):\(second)"
//    }
//
//    let dateFormatter : DateFormatter = {
//       let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        return dateFormatter
//    }()
    
    @State var count : Int = 1
    
    
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)),Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]),
                           center: .center,
                           startRadius: 100,
                           endRadius: 500)
                .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(2)
                
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(4)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.default)
            {
                count = (count + 1) % 4

            }
        }
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        TimerOnReceive()
    }
}

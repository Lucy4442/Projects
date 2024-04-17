//
//  TimeLineView.swift
//  LongPressGesture
//
//  Created by mac on 15/04/24.
//

import SwiftUI

struct TimeLineView: View {
    
    @State var startTime : Date = .now
    @State var pauseAnimation : Bool = false
    
    var body: some View {
        VStack{
            TimelineView(.animation(minimumInterval: 1, paused: pauseAnimation)) { context in
                Text("\(context.date.timeIntervalSince1970)")
                
                let seconds = Calendar.current.component(.second, from: context.date)
//                let seconds = context.date.timeIntervalSince(startTime)
                Text("\(seconds)")
                
                
                Rectangle()
                    .frame(width : seconds < 10 ? 50 : 200,
                           height: seconds < 15 ? 50 : 200)
                    .animation(.spring(), value: seconds)
            }
            
            Button( pauseAnimation ? "PLAY" : "PAUSE")
            {
                pauseAnimation.toggle()
            }
        }
    }
}

struct TimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineView()
    }
}

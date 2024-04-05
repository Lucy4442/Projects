//
//  LongPressGesture.swift
//  LongPressGesture
//
//  Created by mac on 01/04/24.
//

import SwiftUI

struct LongPressGesture: View {
    
    @State var isComplete : Bool = false
    @State var isSuccess : Bool = false
    
    var body: some View {
        VStack{
            
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth : isComplete ? .infinity : 0)
                .frame(height: 60)
                .frame(maxWidth : .infinity,alignment: .leading)
                .background(Color.gray)
            
            HStack{
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 40) {
                        withAnimation(.easeInOut)
                        {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1))
                            {
                                isComplete.toggle()
                            }
                        }
                        else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }
                
                
                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isSuccess = false
                            isComplete = false
                        }
                    }
            }
            
        }
    }
}

struct LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture()
    }
}

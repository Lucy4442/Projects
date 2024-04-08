//
//  SendableProtocol.swift
//  LongPressGesture
//
//  Created by mac on 08/04/24.
//

import SwiftUI

actor CurrentUserManager {
    func updateDatabase(userInfo : MyUserInfo){
        
    }
}

struct MyUserInfo : Sendable {
    var title : String
}

final class MyClassUserInfo: @unchecked Sendable {
    private var title : String
    let queue = DispatchQueue(label: "com.unikwork.MyClassUserInfo")
    init(title : String) {
        self.title = title
    }
    
    func updateName(name: String)
    {
        queue.async {
            self.title = name
        }
    }
}

class SendableProtocolViewModel : ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyUserInfo(title: "info")
        await manager.updateDatabase(userInfo: info)
    }
}

struct SendableProtocol: View {
    
    @StateObject var viewModel = SendableProtocolViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



struct SendableProtocol_Previews: PreviewProvider {
    static var previews: some View {
        SendableProtocol()
    }
}

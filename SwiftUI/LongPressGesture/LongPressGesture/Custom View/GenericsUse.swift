//
//  GenericsUse.swift
//  LongPressGesture
//
//  Created by mac on 10/04/24.
//

import SwiftUI

struct StringModel {
    let info : String?
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct BoolModel {
    let info : Bool?
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

struct GenericViewModel<T> {
    let info : T?
    func removeInfo() -> GenericViewModel {
        GenericViewModel(info: nil)
    }
}

class GenricsUseViewModel : ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var boolModel = BoolModel(info: false)
    @Published var genericStringModel = GenericViewModel(info: "Chill Guys")
    @Published var genericBoolModel = GenericViewModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T : View> : View {
    
    let content : T?
    let title : String
    
    var body: some View{
        VStack{
            Text(title)
            content
        }
    }
}

struct GenericsUse: View {
    
    @StateObject var vm = GenricsUseViewModel()
    
    var body: some View {
        VStack{
            GenericView(content: Text("Custom Content"), title: "New View")
//            GenericView(title: "Hello World!")
            
            Text(vm.stringModel.info ?? "No Data")
            Text(vm.boolModel.info?.description ?? "No Data")
            Text(vm.genericStringModel.info ?? "No Data")
            Text(vm.genericBoolModel.info?.description ?? "No Data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsUse_Previews: PreviewProvider {
    static var previews: some View {
        GenericsUse()
    }
}



import SwiftUI

struct HeaderViewRegular : View {
    var body: some View{
        VStack(alignment : .leading){
            Text("Title")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Description")
                .font(.callout)
            
            RoundedRectangle(cornerRadius: 15)
                .frame(height : 2)
        }
        .frame(maxWidth : .infinity,alignment: .leading)
        .padding()
    }
}

struct myViewBuilder: View {
    var body: some View {
        VStack{
            HeaderViewRegular()
            
            Spacer()
        }
        
        
        
    }
}

struct ViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        myViewBuilder()
    }
}

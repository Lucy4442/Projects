import SwiftUI

struct ArrowCircularProgressView: View {
    @Binding var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 20))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Circle()
                    .trim(from: 0, to: CGFloat(self.progress))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .animation(.linear)
                
                Image(systemName: "arrow.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
                    .offset(x: (geometry.size.width / 2) + 10, y: 0)
                    .rotationEffect(.degrees(Double(self.progress) * 360 - 90))
                    .rotationEffect(.degrees(90))
            }
        }
    }
}

struct ContentView2: View {
    @State private var progress = 0.5
    
    var body: some View {
        VStack {
            ArrowCircularProgressView(progress: $progress)
                .frame(width: 200, height: 200)
                .padding()
            
            Button("Increase Progress") {
                if self.progress < 1.0 {
                    self.progress += 0.1
                }
            }
            .padding()
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

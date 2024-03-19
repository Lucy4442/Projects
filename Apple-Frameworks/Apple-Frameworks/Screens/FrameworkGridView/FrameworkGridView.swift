//
//  ContentView.swift
//  Apple-Frameworks
//
//  Created by mac on 14/03/24.
//

import SwiftUI

struct FrameworkGridView: View {
    
    let columns : [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())]
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns)
                {
                    ForEach(MockData.frameworks)
                    {
                        framework in
                        FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                viewModel.selectedFramework = framework
                            }
                    }
                    
                }
            }
            .navigationTitle("🍎 Frameworks")
            .sheet(isPresented: $viewModel.isShowingFramework) {
                FrameworkDetailView(framework: viewModel.selectedFramework ?? MockData.frameworks[0], isShowingFramework: $viewModel.isShowingFramework)
                    
            }
            
            
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkGridView()
            .preferredColorScheme(.dark)
            
    }
}
struct FrameworkTitleView: View {
    
    let framework : Framework
    var body: some View {
        VStack{
            Image(framework.imageName)
            .resizable()
            .frame(width: 90, height: 90)
            Text(framework.name)
            .font(.title2)
            .fontWeight(.semibold)
            .scaledToFit()
            .minimumScaleFactor(0.6)
        }
        .padding()
    }
}

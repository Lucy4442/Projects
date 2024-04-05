//
//  SwiftUIView.swift
//  CryptoApp
//
//  Created by mac on 29/03/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSettingsView : Bool
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coffeURL = URL(string: "https://www.buymecoffee.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://github.com/Lucy4442/Swift")!
    
    var body: some View {
        NavigationView{
            List{
                coinGeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSettingsView = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsView: .constant(true))
    }
}

extension SettingsView {
   private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free api from Coingecko")
                    .font(.callout)
                    .foregroundColor(Color.theme.accent)
                    .fontWeight(.medium)
            }
            .padding(.vertical)
            Link("Visit coingecko 🔥", destination: coingeckoURL)
            
        } header: {
            Text("CoinGecko")
        }
    }
    
    private var developerSection: some View {
         Section {
             VStack(alignment: .leading){
                 Image("logo")
                     .resizable()
                     .scaledToFit()
                     .frame(height: 100)
                     .clipShape(RoundedRectangle(cornerRadius: 20))
                 Text("This app was developed by Darshan.")
                     .font(.callout)
                     .foregroundColor(Color.theme.accent)
                     .fontWeight(.medium)
             }
             .padding(.vertical)
             Link("Visit Github for source Code 😀", destination: personalURL)
             
         } header: {
             Text("Developer")
         }
     }
    
    private var applicationSection: some View {
         Section {
             Link("Terms of Service", destination: defaultURL)
             Link("Privacy Policy", destination: defaultURL)
             Link("Company Website", destination: defaultURL)
             Link("Learn More", destination: defaultURL)
             
         } header: {
             Text("Developer")
         }
     }
}

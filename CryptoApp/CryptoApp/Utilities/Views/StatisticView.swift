//
//  StatisticView.swift
//  CryptoApp
//
//  Created by mac on 21/03/24.
//

import SwiftUI

struct StatisticView: View {
    
    let stat : StatisticModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 4)
        {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack{
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChance ?? 0)>=0 ? 0 : 180))
                
                Text("\(stat.percentageChance ?? 0,specifier: "%.2f")%")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChance ?? 0)>=0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChance == nil ? 0 : 1)
            
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticView(stat: StatisticModel(title: "Marketcap", value: "$22.5Bn", percentageChance: 25.34))
            StatisticView(stat: StatisticModel(title: "Total Volume", value: "$21.5Tr"))
            StatisticView(stat: StatisticModel(title: "Portfolio Value", value: "$22k", percentageChance: -12.5))
        }
        .previewLayout(.sizeThatFits)
        
        Group{
            StatisticView(stat: StatisticModel(title: "Marketcap", value: "$22.5Bn", percentageChance: 25.34))
            StatisticView(stat: StatisticModel(title: "Total Volume", value: "$21.5Tr"))
            StatisticView(stat: StatisticModel(title: "Portfolio Value", value: "$22k", percentageChance: -12.5))
        }
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}

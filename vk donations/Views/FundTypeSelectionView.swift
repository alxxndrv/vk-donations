//
//  FundTypeSelectionView.swift
//  vk donations
//
//  Created by Георгий Александров on 11.09.2020.
//

import SwiftUI

struct FundTypeSelectionView: View {
    var body: some View {
        VStack {
            targetGoalCard
            regularGoalCard
        }
    }
}

struct FundTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FundTypeSelectionView()
    }
}

extension FundTypeSelectionView {
    var targetGoalCard: some View {
        HStack(){
            Image("target")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36, alignment: .topLeading)
                .scaleEffect(0.7, anchor: .topLeading)
            VStack(alignment: .leading){
                Text("Целевой сбор")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .padding(.horizontal)
                Text("Когда есть определенная цель").font(.system(size: 13, weight: .regular, design: .default))
                    .foregroundColor(Color(#colorLiteral(red: 0.4274509804, green: 0.4705882353, blue: 0.5215686275, alpha: 1)))
                    .padding(.horizontal)
            }.offset(x: -18)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0.7568627451, blue: 0.8, alpha: 1)))
                .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1))))
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.08), lineWidth: 2.33))
        .padding()
    }
    
    var regularGoalCard: some View {
        HStack(){
            Image(systemName: "calendar")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.5411764706, blue: 0.8784313725, alpha: 1)))
                .frame(width: 36, height: 36, alignment: .topLeading)
                .scaleEffect(0.7, anchor: .topLeading)
            VStack(alignment: .leading){
                Text("Регулярный сбор")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .padding(.horizontal)
                Text("Если помощь нужна ежемесячно").font(.system(size: 13, weight: .regular, design: .default))
                    .foregroundColor(Color(#colorLiteral(red: 0.4274509804, green: 0.4705882353, blue: 0.5215686275, alpha: 1)))
                    .padding(.horizontal)
            }.offset(x: -18)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0.7568627451, blue: 0.8, alpha: 1)))
                .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1))))
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.08), lineWidth: 2.33))
        .padding([.horizontal, .bottom])
    }
}

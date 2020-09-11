//
//  ContentView.swift
//  vk donations
//
//  Created by Георгий Александров on 11.09.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DonationsListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DonationsListView: View {
    var body: some View {
        NavigationView {
            VStack {
                    noFundsPlaceholderText
                    createFundButtonPlaceholder
            }
        }
    }
}


extension DonationsListView {
    var createFundButtonPlaceholder: some View {
        NavigationLink(
            destination: Text("Destination"),
            label: {
            Text("Создать сбор")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.182649374, green: 0.5328009129, blue: 0.822655499, alpha: 1))))
            })
    }
    
    var noFundsPlaceholderText: some View {
        Text("У Вас пока нет сборов.\nНачните доброе дело.")
            .font(.system(size: 16, weight: .regular, design: .default))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(#colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)))
            .padding()
    }
}

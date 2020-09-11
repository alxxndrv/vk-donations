//
//  PersonalizationView.swift
//  vk donations
//
//  Created by Георгий Александров on 12.09.2020.
//

import SwiftUI

struct PersonalizationView: View {
    var body: some View {
        Form {
            Section(header: Text("Автор").vkUISectionTitleFont(), content: {
                AuthorPickerView()
            })
            
        }
    }
}

struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationView()
    }
}

struct AuthorPickerView: View {
    var body: some View {
        ZStack {
            TextField("", text: .constant("Георгий Александров")).disabled(true).vkUITextField()
            HStack {
                Spacer()
                Image(systemName: "chevron.down").font(.system(size: 18, weight: .bold)).padding(.horizontal).foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0.7568627451, blue: 0.8, alpha: 1)))
            }
        }
    }
}


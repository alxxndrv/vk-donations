//
//  PersonalizationView.swift
//  vk donations
//
//  Created by Георгий Александров on 12.09.2020.
//

import SwiftUI

struct PersonalizationView: View {
    @EnvironmentObject var data: TargetFundData
    @State var selection = 2
    @State var dateAsString = "Выберите дату"
    
    func getDateAsString() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMMM yyyy"
        dateformatter.locale = Locale(identifier: "ru")
        dateAsString = dateformatter.string(from: data.endDate)
        
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Автор").vkUISectionTitleFont(), content: {
                    AuthorPickerView()
                })
                Section(header: Text("Сбор завершится"), content: {
                    VKUIRadioButtons(selection: $selection)
                    
                })
                Section(header: Text("Дата окончания")) {
                DatePicker(dateAsString, selection: $data.endDate.didSet {_ in
                    getDateAsString()
                }, in: Date(timeIntervalSinceNow: 86400)...,displayedComponents: .date)
                    .disabled(selection == 1)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 1))))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.12), lineWidth: 0.5))
            }
            }.listStyle(GroupedListStyle())
            Spacer()
            NavigationLink(
                destination: Text("Destination")) {
                vkUIButton(text: "Создать сбор", disabled: selection == 2 && dateAsString == "Выберите дату")
            }.disabled(
                (selection == 2 && dateAsString == "Выберите дату")
            )
        }
        
    }
}

struct vkUIButton: View {
    var text = String()
    var disabled = false
    var body: some View {
        Text(text)
            .font(.system(size: 17, weight: .medium, design: .default))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.2862745098, green: 0.5254901961, blue: 0.8, alpha: 1))))
            .padding()
            .opacity(disabled ? 0.4 : 1)
    }
}

extension Binding {
    /// Wrapper to listen to didSet of Binding
    func didSet(_ didSet: @escaping ((newValue: Value, oldValue: Value)) -> Void) -> Binding<Value> {
        return .init(get: { self.wrappedValue }, set: { newValue in
            let oldValue = self.wrappedValue
            self.wrappedValue = newValue
            didSet((newValue, oldValue))
        })
    }
    
    /// Wrapper to listen to willSet of Binding
    func willSet(_ willSet: @escaping ((newValue: Value, oldValue: Value)) -> Void) -> Binding<Value> {
        return .init(get: { self.wrappedValue }, set: { newValue in
            willSet((newValue, self.wrappedValue))
            self.wrappedValue = newValue
        })
    }
}

struct VKUIRadioButtons: View {
    @Binding var selection: Int
    var body: some View {
        VStack {
            HStack {
                if selection == 2 {
                    radioButtonStandalone
                } else {
                    radioButtonActive
                }
                Text("Когда соберем сумму")
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                selection = 1
                }
            }
            .padding(.vertical)
            HStack {
                if selection == 1 {
                    radioButtonStandalone
                } else {
                    radioButtonActive
                }
                Text("В определенную дату")
                
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                selection = 2
                }
            }
        }
    }
}

extension VKUIRadioButtons {
    var radioButtonActive: some View {
        ZStack {
            Circle()
                .stroke(Color(#colorLiteral(red: 0.2470588235, green: 0.5411764706, blue: 0.8784313725, alpha: 1)), lineWidth: 2.0)
                .frame(width: 24, height: 24, alignment: .center)
                .padding(.trailing, 5)
            Circle()
                .fill(Color(#colorLiteral(red: 0.2470588235, green: 0.5411764706, blue: 0.8784313725, alpha: 1)))
                .frame(width: 18, height: 18, alignment: .center)
                .padding(.trailing, 5)
        }
    }
    
    var radioButtonStandalone: some View {
        Circle()
            .stroke(Color(#colorLiteral(red: 0.7215686275, green: 0.7568627451, blue: 0.8, alpha: 1)), lineWidth: 2.0)
            .frame(width: 24, height: 24, alignment: .center)
            .padding(.trailing, 5)
    }
    
}


struct PersonalizationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        PersonalizationView()
        }
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


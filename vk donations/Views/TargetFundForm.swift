//
//  TargetFundForm.swift
//  vk donations
//
//  Created by Георгий Александров on 11.09.2020.
//

import SwiftUI
import Combine

class TargetFundData: ObservableObject {
    @Published var title = ""
    @Published var goal = "0₽" {
        didSet {
            if self.goal.count > 1 && self.goal.prefix(1) == "0" {
                self.goal = String(self.goal.dropFirst())
            }
            if self.goal.count > 12 {
                self.goal = oldValue
            }
            if self.goal.count == 0 {
                self.goal = "0"
            }
        }
        
    }
    @Published var textGoal = ""
    @Published var description = ""
}


extension View {
    func vkUITextField() -> some View {
        self.padding(.all, 12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9607843137, alpha: 1))))
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.12), lineWidth: 0.9))
    }
    func vkUISectionTitleFont() -> some View {
        self.font(.system(size: 16))
    }
}

struct TargetFundForm: View {
    
    @ObservedObject var data = TargetFundData()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = UITableViewCell.SeparatorStyle.none

    }
    var body: some View {
        Form {
            UploadPhotoPlaceholder()
            Section(header: Text("Название сбора").vkUISectionTitleFont()) {
                TextField("Название сбора", text: $data.title).vkUITextField()
            }
            Section(header: Text("Сумма, ₽").vkUISectionTitleFont()) {
                TextField("Сколько нужно собрать?", text: $data.goal).vkUITextField().keyboardType(.decimalPad)
            }
            Section(header: Text("Цель").vkUISectionTitleFont()) {
                TextField("Например, лечение человека", text: .constant("")).vkUITextField()
            }
            Section(header: Text("Описание").vkUISectionTitleFont()) {
                TextField("На что пойдут деньги и как они кому-то помогут?", text: .constant("")).vkUITextField()
              }
            Section(header: Text("Куда получать деньги")) {
                PaymentMethodPicker()
            }
            Section {
                ZStack {
                    NavigationLink(destination: Text("test")) {
                        Text("Продолжить")
                            .font(.system(size: 17, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.2862745098, green: 0.5254901961, blue: 0.8, alpha: 1))))
                            .padding()
                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

struct PhotoPlaceholder: View {
    var image = UIImage()
    var body: some View {
        Image(uiImage: image).clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct UploadPhotoPlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4])).frame(height: 160)
                .padding()
                HStack {
                    Image("picture_outline_28")
                        .resizable()
                        .frame(width: 28, height: 28, alignment: .center)
                    Text("Загрузить обложку").font(.system(size: 16, weight: .medium, design: .default))
                }
        }.foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.5411764706, blue: 0.8784313725, alpha: 1)))
        
    }
}

struct plchldr: PreviewProvider {

    static var previews: some View {
        Group{
            UploadPhotoPlaceholder()
            PaymentMethodPicker()
        }
    }
}


struct PaymentMethodPicker: View {
    var body: some View {
        ZStack {
            TextField("", text: .constant("Счёт VK Pay · 1234")).disabled(true).vkUITextField()
//                .padding()
            
            HStack {
                Spacer()
                Image(systemName: "chevron.down").font(.system(size: 18, weight: .bold)).padding(.horizontal).foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0.7568627451, blue: 0.8, alpha: 1)))
            }
//            .padding()
        }
    }
}


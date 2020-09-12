//
//  RegularFundForm.swift
//  vk donations
//
//  Created by Георгий Александров on 12.09.2020.
//

import SwiftUI

struct RegularFundForm: View {
    
    @ObservedObject var data = TargetFundData()
    
    @State var inputImage: UIImage?
    
    @State var image: Image?
    
    func loadImage() {
        withAnimation {
            guard inputImage != nil else { return }
        }
        
    }
    
    
    @State var showingImagePicker = false
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = UITableViewCell.SeparatorStyle.none


    }
    var body: some View {
        Form {
            if (inputImage == nil || inputImage == UIImage()) {
                UploadPhotoPlaceholder().onTapGesture(count: 1, perform: {
                    showingImagePicker = true
                })
            } else {
                PhotoPlaceholder(image: $inputImage)
            }
            Section(header: Text("Название сбора").vkUISectionTitleFont()) {
                TextField("Название сбора", text: $data.title).vkUITextField()
            }
            Section(header: Text("Сумма в месяц, ₽").vkUISectionTitleFont()) {
                TextField("Сколько нужно в месяц?", text: $data.goal).vkUITextField().keyboardType(.decimalPad)
            }
            Section(header: Text("Цель").vkUISectionTitleFont()) {
                TextField("Например, лечение человека", text: $data.textGoal).vkUITextField()
            }
            Section(header: Text("Описание").vkUISectionTitleFont()) {
                TextField("На что пойдут деньги и как они кому-то помогут?", text: $data.description).vkUITextField()
              }
            Section(header: Text("Куда получать деньги")) {
                PaymentMethodPicker()
            }
            Section(header: Text("Автор").vkUISectionTitleFont(), content: {
                AuthorPickerView()
            })
            Section {
                ZStack {
                    NavigationLink(destination: SnippetPreviewView()
                    .environmentObject(data)) {
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage.didSet { _ in
                
                data.image = inputImage
                
            })
        }
    }
}


struct RegularFundForm_Previews: PreviewProvider {
    static var previews: some View {
        RegularFundForm()
    }
}

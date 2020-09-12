//
//  FundDetailedView.swift
//  vk donations
//
//  Created by Георгий Александров on 12.09.2020.
//

import SwiftUI


extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

struct FundDetailedView: View {
    @EnvironmentObject var data: TargetFundData
    @State var value = Float()
    
    func getValue() {
        
        value = Float(Float(data.currentProgress)! / Float(data.goal)!)
        print(value, data.currentProgress, data.goal)
    }
    
    @State var tint = TimeInterval()
    
    
    var body: some View {
        
            ScrollView {
            VStack(alignment: .leading){
                Image(uiImage: data.image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(height: 140)
                    .clipShape(Rectangle())
                    .edgesIgnoringSafeArea(.top)
                VStack(alignment: .leading, spacing: 4){
                    Text(data.title).font(.system(size: 24, weight: .bold, design: .default))
                    Text("Автор Георгий Александров").font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(Color(#colorLiteral(red: 0.4274509804, green: 0.4705882353, blue: 0.5215686275, alpha: 1)))
                    Text("Сбор закончится через \(Int(ceil(tint / 86400))) дней").font(.system(size: 13, weight: .regular, design: .default))
                        .foregroundColor(Color(#colorLiteral(red: 0.4274509804, green: 0.4705882353, blue: 0.5215686275, alpha: 1)))
                }
    //            .padding(.top, -40)
                .padding()
                Divider().padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Нужно собрать до 10 сентября").font(.system(size: 14, weight: .regular, design: .default))
                    
                    ProgressBarWithLabel(goal: $data.goal, current: $data.currentProgress, value: $value).frame(height: 24)
                    Divider()
                }.padding()
                Text(data.description)
                    .padding([.horizontal, .bottom])
                    .lineLimit(nil)
                Divider().padding(.horizontal)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            }.overlay(VStack{
                Spacer()
                Divider().padding()
                bottomHintView
            })
            .onAppear {
                self.tint = self.data.endDate  - Date()
            }
        
    }
}

extension FundDetailedView {
    var bottomHintView: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Собрано \(data.currentProgress) ₽ из \(data.goal) ₽")
                ProgressBar(value: $value).frame(height: 4)
                
            }
            Button(action: {
                print("ff")
                self.data.currentProgress = String(Int(self.data.currentProgress)! + 100)
                self.getValue()
            }) {
            Text("Помочь")
                .font(.system(size: 15, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 7.5)
                .padding(.horizontal, 8)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.2941176471, green: 0.7019607843, blue: 0.2941176471, alpha: 1))))
            }
        }.padding()
    }
}

struct ProgressBarWithLabel: View {
    @Binding var goal: String
    @Binding var current: String
    @Binding var value: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                
                    .foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0.7568627451, blue: 0.8, alpha: 0.3)))
                    .overlay(HStack {
                        Spacer()
                        Text("\(self.goal)₽")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(Color(#colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1))).padding(.trailing)
                    })
                
                
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(#colorLiteral(red: 0.2941176471, green: 0.7019607843, blue: 0.2941176471, alpha: 1)))
                        .cornerRadius(6)
                        .animation(.linear)
                        .overlay(HStack {
                            Spacer()
                            Text("\(self.current)₽")
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .foregroundColor(.white).padding(.trailing)
                        })
                        
                    
                    
                
            }.cornerRadius(6.0)
        }
    }
}

struct FundDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        FundDetailedView()
    }
}

//
//  SnippetView.swift
//  vk donations
//
//  Created by Георгий Александров on 12.09.2020.
//

import SwiftUI


struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(2.0)
        }
    }
}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}

struct SnippetView: View {
    @EnvironmentObject var data: TargetFundData
    
    @State var progress: Float = 0.2
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: data.image ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(height: 140, alignment: .center)
                .clipShape(RoundedCorners(tl: 10, tr: 10, bl: 0, br: 0))
                
                
            VStack(alignment: .leading) {
                Text(data.title).fontWeight(.semibold).font(.system(size: 15))
                Text("Георгий Александров · Закончится через 5 дней").fontWeight(.regular).font(.system(size: 13)).foregroundColor(Color(#colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)))
                Divider()
                
                HStack(alignment: .center){
                    VStack(alignment: .leading) {
                        Text(progress == 0 ? "Помогите первым!" : "Пожертвовало \(Int(progress*10)) человек").font(.system(size: 13, weight: .regular, design: .default))
                        ProgressBar(value: $progress).frame(height: 4)
                    }
                    Button(action: {}, label: {
                        Text("Помочь")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).frame(height: 30))
                    })
                }
                            
                
            }
            .padding([.horizontal, .bottom])
            .padding(.top, 3)
      
        }
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.08), lineWidth: 0.5))
        .padding()
    }
}

struct SnippetView_Previews: PreviewProvider {
    static var previews: some View {
        SnippetView()
    }
}

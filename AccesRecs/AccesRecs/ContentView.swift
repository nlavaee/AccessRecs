//
//  ContentView.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 9/27/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import SwiftUI


struct Accessibility_Categories: Identifiable {
    let id: UUID = UUID()
    let name: String

}
struct ContentView: View {
    
    @State var showingVision = false
    @State var showingMotion = false
    @State var categoryMotion:String = "Motion"
    @State var categoryVision:String = "Vision"
    
    //var categoryType: String = "" // Motion = false, Vision = true
//    let categoryList = [
//        Accessibility_Categories(name: "Mobility"),
//        Accessibility_Categories(name: "Vision")
//    ]
    var body: some View {
        //GeometryReader { geometry in
        VStack{
            
            Text("Accessibility Categories").bold().foregroundColor(.green).font(.title).baselineOffset(90)
                .padding(.horizontal, 20)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .padding(.vertical, 15)
            
            Image("digitalAccess")
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
                .padding()
                .opacity(0.3)
            
        
           //Text("Comprehensive list of Accessibility features for diversely-abled users")
            Text("")
            .fixedSize(horizontal: false, vertical: true)
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
           

        
           Button(action: {
                    self.showingMotion.toggle()
                    
                }) {
                 HStack {
//                    Image(systemName: "slow-motion")
                    Image(uiImage: UIImage(named: "slow-motion")!).colorInvert()
                        .font(.title).foregroundColor(.white)
                    Text("Motion")
                        .fontWeight(.semibold).foregroundColor(.white)
                           .font(.title)
                   }
            }.sheet(isPresented: $showingMotion, content:  {
                GuideList(categoryType: self.categoryMotion)
                //ModalPopup(showingModal: self.$showingMotion)
            }).buttonStyle(PlainButtonStyle())
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemGreen)]), startPoint: .leading, endPoint: .trailing))
//            .foregroundColor(.green)
            .cornerRadius(40)
            .padding(.horizontal, 20)
            
            
//            .padding(.horizontal, 1)
            
            .padding(.vertical, 40)
            Button(action: {
                    self.showingVision.toggle()
                    
                }) {
                     HStack {
                           Image(systemName: "eye")
                            .font(.title).foregroundColor(.white)
                        Text("Vision")
                            .fontWeight(.semibold).foregroundColor(.white)
                               .font(.title)
                       }
            }.sheet(isPresented: $showingVision, content:  {
                GuideList(categoryType: self.categoryVision)
                //ModalPopup(showingModal: self.$showingVision)
                })//.buttonStyle(RoundedButton())//.foregroundColor(.clear).background(guide.imgBefore)
//                .mask(Circle()).accentColor(.white).fixedSize()
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGreen), Color(.systemGreen)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)

//                .padding(.horizontal, 1)
        //}
        }
    }
}


//public struct RoundedButton: ButtonStyle {
//
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
////            .foregroundColor(configuration.isPressed ? .red : .blue)
//            .accentColor(.white)
//            .padding()
//            .background(Color.green)
//            .cornerRadius(10)
//    }
//}



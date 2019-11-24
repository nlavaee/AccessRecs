//
//  DropDown.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 11/13/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import SwiftUI

//struct DropDownView: View {
//       var guide: Guide
//    var body: some View {
//
//        DropDown(guide: guide)
//    }
//}

struct ModalPopup : View {
    @Binding var showingModal:Bool

    var body: some View {
        Button(action: {
            self.showingModal = false
        }) {
            Text("Dismiss").frame(height: 60)
        }
    }
}

struct DropDown : View {
    
//    @State var expand = false
    var guide: Guide
    @State var toggleTrue = false
    @State var showingDetail = false
    @State var showingUsage = false
    
    var body : some View {
     
        ZStack {

                LinearGradient(gradient: .init(colors: [.white, .green]), startPoint: .top, endPoint: .bottom)
//            Color.green
//                .edgesIgnoringSafeArea(.all)
            VStack {
            
               VStack {
                Text(guide.name).fontWeight(.heavy).foregroundColor(.green).font(.title)
//                    .minimumScaleFactor(0.01)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    
                }.padding()
                VStack {
                    Text(guide.Description).fontWeight(.regular).font(.subheadline).multilineTextAlignment(.center)
                       .font(.body)
                       .minimumScaleFactor(0.01)
                       .lineLimit(nil)
                }.padding()
           // if !expand {
                Button(action: {
                    self.showingDetail.toggle()
                    
                }) {
                    
                    Text("Show Feature").font(.headline)
                    .minimumScaleFactor(0.01)
                    .lineLimit(nil)
                    .padding()
                }.sheet(isPresented: $showingDetail, content:  {
                    TemplateGuideView(guide: self.guide)
                    ModalPopup(showingModal: self.$showingDetail)
                    })//.foregroundColor(.clear).background(guide.imgBefore)
                
                Button(action: {
                    
                    self.toggleTrue.toggle()
                    
                }) {
                    
                    Text("Enable Feature Steps").font(.headline)
                    .minimumScaleFactor(0.01)
                    .lineLimit(nil)
                    .padding()
                }.sheet(isPresented: $toggleTrue, content : {
                    SettingsStepsView(guide: self.guide)
                    ModalPopup(showingModal: self.$toggleTrue)
                    
                })
                
                Button(action: {
                    
                    self.showingUsage.toggle()
                    
                }) {
                    
                    Text("Show Usage Steps").font(.headline)
                    .minimumScaleFactor(0.01)
                    .lineLimit(nil)
                    .padding()
                }.sheet(isPresented: $showingUsage, content: {
                    UsageGuideView(guide: self.guide)
                    ModalPopup(showingModal: self.$showingUsage)
                })
                    
            }
            .padding()
           // .background(LinearGradient(gradient: .init(colors: [.white, .green]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
    //        .animation(.spring())
            }
        }
    
}



//Text("placeholder")
//                     // if !toggleTrue {
////                                  Text("Before")
//                                      .frame(alignment:.center)
//                                      .padding([.horizontal])
////                                      .overlay(
////                                          RoundedRectangle(cornerRadius: 4)
////                                              .stroke(Color.gray, lineWidth:2)
////                                      )
//                                      .lineLimit(1)
//                                  guide.imgBefore
//                                      .resizable()
//                                      .aspectRatio(contentMode: .fit)
//                                  //}
//                      //                .scaledToFit()
//                                  Spacer()
//                                      .frame(height:10)
//
////                                 if toggleTrue {
////                                  Text("After")
////                                      .padding([.horizontal])
////                                      .overlay(
////                                          RoundedRectangle(cornerRadius: 4)
////                                              .stroke(Color.gray, lineWidth:2)
////                                      )
////                                      .lineLimit(1)
////                                  guide.imgAfter
////                                      .resizable()
////                                      .aspectRatio(contentMode: .fit)
////                                 }

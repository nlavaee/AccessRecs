//
//  TemplateGuideView.swift
//  AccesRecs
//
//  Created by Amaris Sim on 10/7/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//


import Foundation
import UIKit
import SwiftUI


struct TemplateGuideView: View {
    @State private var toggleTrue = false
    @State var zoomPhoto = true
    var guide: Guide

    
    var body: some View {
        
        
        VStack{
            
            VStack{
                HStack(){
                    Text(guide.name)
                        .font(.headline)
                        .lineLimit(nil)
                     Spacer()
                     Toggle(isOn: $toggleTrue){
                        Text(guide.name)
                     }
                     .labelsHidden()
                    }
            }
            .padding()
//          line 43-52
//          before text box and image
            if !toggleTrue {
                Text("Before")
                    .frame(alignment:.center)
                    .padding([.horizontal])
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth:2)
                    )
                    .lineLimit(1)
                guide.imgBefore
                    .resizable()
                    .aspectRatio(contentMode: zoomPhoto ? .fit : .fill)
                    .shadow(radius: 2)
                    .animation(Animation.spring(
                        response: 0.87, dampingFraction: 0.7, blendDuration: 1))
                    .onTapGesture {
                        self.zoomPhoto.toggle()
                }
    //                .scaledToFit()
                Spacer()
                    .frame(height:10)
            }
            
           if toggleTrue {
            Text("After")
                .padding([.horizontal])
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth:2)
                )
                .lineLimit(1)
            guide.imgAfter
                  .resizable()
                  .aspectRatio(contentMode: zoomPhoto ? .fit : .fill)
                  .shadow(radius: 2)
                  .animation(Animation.spring(
                   response: 0.87, dampingFraction: 0.7, blendDuration: 1))
                  .onTapGesture {
                     self.zoomPhoto.toggle()
              }
           }
        }
//        .padding()
//        Spacer()
        }

}





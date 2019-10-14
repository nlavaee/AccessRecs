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

import SwiftUI


struct TemplateGuideView: View {
    @State private var toggleTrue = false
    var guide: Guide

    var body: some View {
        
        
        VStack{
//            Text("hello world")
//          line 23 - 36
//          title, toggle button, description
//          note: padding to apply goes to outside
            VStack{
                HStack(){
                    Text(guide.name)
                        .font(.headline)
                     Spacer()
                     Toggle(isOn: $toggleTrue){
                        Text(guide.name)
                     }
                     .labelsHidden()
                    }
                Text(guide.Description)
                    .font(.body)
                    .lineLimit(nil)
            }
            .padding()
//          line 43-52
//          before text box and image
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
                .aspectRatio(contentMode: .fit)
//                .scaledToFit()
            Spacer()
                .frame(height:10)
            
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
                .aspectRatio(contentMode: .fit)
           }
        }
//        .padding()
//        Spacer()
        }

}

//struct before_img_togg : View{
//    var guide: Guide
//
//    var body : some View {
//
//        GeometryReader { geometry in
//
//            guide.imgBefore
//            .frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
//
//        }
//    }
//}
//#if DEBUG
//struct TemplateGuideView_Preview: PreviewProvider {
//    
//    static var previews: some View {
//        TemplateGuideView(guide)
//    }
//}
//#endif

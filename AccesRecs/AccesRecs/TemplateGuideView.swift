//
//  TemplateGuideView.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

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
        
        VStack(){
            
//          line 23 - 36
//          title, toggle button, description
//          note: padding to apply goes to outside
            VStack(alignment: .leading){
                HStack(){
                    Text(guide.name)
//                        .font(.system(size: 30))
                        .font(.headline)
                    
//                        .lineLimit(nil)
                     Spacer()
                     Toggle(isOn: $toggleTrue){
                        Text("Before " + guide.name)
                            .lineLimit(nil)
                     }
                     .labelsHidden()
                    }
                
                
                Text(guide.Description)
                    .font(.subheadline)
                    .lineLimit(nil)
            }
            .padding()
            Spacer()

//          line 43-52
//          before text box and image
            Text("Before")
                .frame(alignment:.center)
                .padding([.horizontal])
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth:2)
                )
                .lineLimit(nil)
            
            Image(uiImage: UIImage(named: guide.imageBefore)!)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Spacer()
                .frame(height:50)
            
           if toggleTrue {
            Text("After")
                .padding([.horizontal])
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth:2)
                )
                .lineLimit(nil)
            Image(uiImage: UIImage(named: guide.imageAfter)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
           }
        }
        .padding()
    }
}

//#if DEBUG
//struct TemplateGuideView_Preview: PreviewProvider {
//    static var previews: some View {
//        TemplateGuideView()
//    }
//}
//#endif

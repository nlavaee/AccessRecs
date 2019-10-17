//
//  GuideList.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

// creating the whole list of the Guide



import SwiftUI
import UIKit
import Foundation



struct GuideList: View {
    
    
    @State private var searchTerm: String = ""
    
    var body: some View {
        
    
        
        VStack(){
            
        NavigationView {
            Group{
                Text("")
                .font(.title)
                SearchBar(text: $searchTerm)
                List(Guidedata.filter { i in
                    if(!self.searchTerm.isEmpty){
                        if(i.name.localizedCaseInsensitiveContains(self.searchTerm)){
                            return true
                        }
                    }
                    else {
                         return true
                    }
                    return false
                }) { guide in
    
                            NavigationLink(destination: TemplateGuideView(guide: guide)){
                                GuideRow(guide: guide)
                                Spacer()
                            
                        }
                       
                    }
                
                }
                .navigationBarTitle(Text("Guide"), displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button("") {
                    print("tapped")
                })

            }
        }
    
    }

}


//struct GuideList_Previews: PreviewProvider {
//    static var previews: some View {
//        GuideList()
//    }
//}

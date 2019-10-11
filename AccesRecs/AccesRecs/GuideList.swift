//
//  GuideList.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

// creating the whole list of the Guide



import SwiftUI

struct GuideList: View {

    @State private var searchTerm: String = ""

    var body: some View {
        VStack{
            Text("Guide")
                .font(.title)
        NavigationView {
            Group{
                SearchBar(text: $searchTerm)
                            List(Guidedata) { guide in
                            NavigationLink(destination: TemplateGuideView(guide: guide)){
                                GuideRow(guide: guide)
                                        }
                                    }
                }

                .navigationBarHidden(true)
                .navigationBarItems(trailing:
                    Button("")                        {
                        print("tapped")
                    }
                    
                )
            }
            
        }
    }
}

struct GuideList_Previews: PreviewProvider {
    static var previews: some View {
        GuideList()
    }
}

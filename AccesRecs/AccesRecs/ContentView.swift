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
    
    let categoryList = [
        Accessibility_Categories(name: "Mobility"),
        Accessibility_Categories(name: "Vision")
    ]
    var body: some View {
        List(categoryList) { cat in
            Text(cat.name)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


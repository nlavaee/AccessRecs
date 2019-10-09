//
//  TestList.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import Foundation
import SwiftUI

struct TestList: View {

    var body: some View {
        
        NavigationView {
            
            List(Testdata) { test in
            
                NavigationLink(destination: TestView()){
                    
                    TestRow(test: test)
                }
            }
        }
        
        
    }
}

struct TestList_Previews: PreviewProvider {
    static var previews: some View {
        TestList()
    }
}

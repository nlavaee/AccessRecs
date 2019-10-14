//
//  TestList.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//
//
import Foundation
import SwiftUI

struct TestList: View {
    
//    private var destination: AnyView
    
    
    var body: some View {

        NavigationView {

            List(Testdata) { test in
                
                if(test.name == "Colorblind"){
                    NavigationLink(destination: ColorBlindTestView()){ TestRow(test: test) }
                }
                else if(test.name == "Large Text") {
                    NavigationLink(destination: LargeTextTestView()){ TestRow(test: test) }
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


//class TestList: UIViewController {
//    override func viewDidLoad(){
//
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
//        let list = List {
//            TestRow(test: Testdata[0])
//        }
//
//        // List
//        self.view.addSubview(list)
//    }
//}

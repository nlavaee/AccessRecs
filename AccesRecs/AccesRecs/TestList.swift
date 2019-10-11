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

    var body: some View {

        NavigationView {

            List(Testdata) { test in

                NavigationLink(destination: LargeTextTestView()){
                //NavigationLink(destination: ColorBlindTestView()){
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

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

//struct TestList: View {
//
//    var body: some View {
//
//        NavigationView {
//
//            List(Testdata) { test in
//
//                NavigationLink(destination: LargeTextTestView()){
//                //NavigationLink(destination: ColorBlindTestView()){
//                    TestRow(test: test)
//                }
//            }
//        }
//    }
//}
//
//struct TestList_Previews: PreviewProvider {
//    static var previews: some View {
//        TestList()
//    }
//}


class TestList: UITableViewController {
    
    var tests = Testdata
    
    override func viewDidLoad(){

        super.viewDidLoad()
        self.tableView.register(TestRow.self, forCellReuseIdentifier: "TestRow")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = view.frame
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 110
        self.tableView.backgroundColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestRow") as! TestRow
        cell.test = tests[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.tests[indexPath.row].name == "Colorblind") {
            let testVC = ColorBlindTestViewController()
            testVC.tests = self.tests[indexPath.row].tests
            present(testVC, animated: true, completion: nil)
        } else if(self.tests[indexPath.row].name == "Large Text"){
            let testVC = LargeTextTestViewController()
            present(testVC, animated: true, completion: nil)
        }
        
    }
    

}

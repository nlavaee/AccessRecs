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


class TestList: UITableViewController, UINavigationControllerDelegate {
    
    var tests : [Test] = []
    
    override func viewDidLoad(){

        super.viewDidLoad()
        
        self.navigationController?.delegate = self
       let home_icon = UIImage(named: "home_icon")
       self.navigationController?.navigationBar.backIndicatorImage = home_icon
       self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = home_icon
       self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.register(TestRow.self, forCellReuseIdentifier: "TestRow")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = view.frame
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 110
        self.tableView.backgroundColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
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
            navigationController?.pushViewController(testVC, animated: true)
//            present(testVC, animated: true, completion: nil)
        } else if(self.tests[indexPath.row].name == "Large Text"){
            let testVC = LargeTextTestViewController()
            navigationController?.pushViewController(testVC, animated: true)
//            present(testVC, animated: true, completion: nil)
        } else if(self.tests[indexPath.row].name == "Grid"){
            let testVC = GridViewController()
            navigationController?.pushViewController(testVC, animated: true)
        } else if(self.tests[indexPath.row].name == "Astigmatism"){
            let testVC = AstigmatismViewController()
            navigationController?.pushViewController(testVC, animated: true)
        } else if(self.tests[indexPath.row].name == "Maze"){
            let testVC = MobilityMazeTest()
            navigationController?.pushViewController(testVC, animated: true)
        } else if(self.tests[indexPath.row].name == "Typing") {
            let testVC = MobilityTypingTest()
            navigationController?.pushViewController(testVC, animated: true)
        } else if(self.tests[indexPath.row].name == "Drawing") {
            let testVC = MobilityDrawingTest()
            navigationController?.pushViewController(testVC, animated: true)
        } else if(self.tests[indexPath.row].name == "Fingers") {
            let testVC = FingersViewController()
            navigationController?.pushViewController(testVC, animated: true)
        }
        
    }
    

}

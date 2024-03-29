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
        if traitCollection.userInterfaceStyle == .dark{
            self.tableView.backgroundColor = UIColor.black

        }
        else{
            self.tableView.backgroundColor = UIColor.white

        }
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
            let testVC = GridTestViewController()
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

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

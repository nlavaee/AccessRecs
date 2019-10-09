//
//  ViewController.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/7/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

import UIKit

class GuideVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    let data = [
        "Zoom",
        "Large Text",
        "Voice Control",
        "Touch"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        

    }
    
    
    
//    // add a way to go back
//
//
//    let tableView: UITableView = {
//        let tV = UITableView()
//        tV.separatorStyle = .none;
//        tV.allowsSelection = false;
//        return tV;
//
//    }()
//
//    let guideCellID = "guideCell"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupTableView()
//    }
//
//    func setupNavigationBar(){
//        navigationItem.title = "Guide"
//        navigationController?.navigationBar.barTintColor = .black
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
//    }
//
//    func setupTableView(){
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.register(GuideCell.self, forCellReuseIdentifier: guideCellID)
//        view.addSubview(tableView);
//        tableView.translatesAutoresizingMaskIntoConstraints = false;
//
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.padding
//
//
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: guideCellID, for: indexPath) as! GuideCell
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//}
//
//class GuideCell: UITableViewCell {
//
//    let cellView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        view.layer.shadowOpacity = 0.2
//        return view
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setup()
//    }
//
//    func setup(){
//        addSubview(cellView)
//
//        cellView.translatesAutoresizingMaskIntoConstraints = false
//
////        cellView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        cellView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        cellView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        cellView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}

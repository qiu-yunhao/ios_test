//
//  TestViewController.swift
//  day1
//
//  Created by hello on 2022/7/10.
//

import Foundation
import UIKit

class TestController: UIViewController,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.nameLabel.text = datas[indexPath.row].name
        cell.timeLabel.text = datas[indexPath.row].time
        return cell
    }
    
    
    let datas : [Data] = Store.getDatas()
    
    let table : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .green
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        table.dataSource = self
        table.register(Cell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    

}



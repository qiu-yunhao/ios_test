//
//  ViewController.swift
//  Day5
//
//  Created by hello on 2022/9/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let cellNotification = "cellNotification"
    
    private lazy var courseView: UITableView = {
        let view = UITableView()
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        view.dataSource = self
        view.delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let datas: [Course_Title] = {
        let s = Store()
        return s.getCourses()
    }()
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        view.addSubview(courseView)
        let headView = getHeadView()
        view.addSubview(headView)
        
        NSLayoutConstraint.activate([
            courseView.topAnchor.constraint(equalTo: headView.bottomAnchor),
            courseView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            courseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            courseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            headView.leadingAnchor.constraint(equalTo: courseView.leadingAnchor),
            headView.trailingAnchor.constraint(equalTo: courseView.trailingAnchor),
            headView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func moveWithCell() {
        
    }

}


extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseCell
        cell.bind(title: datas[indexPath.row])
        cell.headView = self.scrollView
        initCellObsever(cell: cell.self)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == self.scrollView) {
            var dict = [String: CGFloat]()
            dict["offset"] = scrollView.contentOffset.x
            NotificationCenter.default.post(name: Notification.Name(cellNotification), object: nil,userInfo: dict)
        }
    }
    
    func initCellObsever(cell : CourseCell) {
        NotificationCenter.default.addObserver(cell.self, selector: #selector(cell.moveWithHeadView), name: Notification.Name(cellNotification), object: nil)
    }
    
    
}

extension ViewController {
    func getHeadView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let first = UIView()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.backgroundColor = .white
        view.addSubview(first)
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            first.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            first.widthAnchor.constraint(equalToConstant: 50),
            first.topAnchor.constraint(equalTo: view.topAnchor),
            first.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: first.trailingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        var last: UIView? = nil
        for i in 1...7 {
            let a = UIView()
            a.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(a)
            a.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            a.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            a.widthAnchor.constraint(equalToConstant: 50).isActive = true
            if(last == nil) {
                a.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            } else {
                a.leadingAnchor.constraint(equalTo: last!.trailingAnchor).isActive = true
            }
            last = a
            let weekDay = UILabel()
            weekDay.text = "星期\(i)"
            weekDay.textAlignment = .center
            weekDay.translatesAutoresizingMaskIntoConstraints = false
            a.addSubview(weekDay)
            let date = UILabel()
            date.translatesAutoresizingMaskIntoConstraints = false
            a.addSubview(date)
            NSLayoutConstraint.activate([
                weekDay.topAnchor.constraint(equalTo: a.topAnchor),
                weekDay.heightAnchor.constraint(equalTo: a.heightAnchor, multiplier: 0.6),
                weekDay.leadingAnchor.constraint(equalTo: a.leadingAnchor),
                weekDay.trailingAnchor.constraint(equalTo: a.trailingAnchor),
                
                date.topAnchor.constraint(equalTo: a.bottomAnchor),
                date.leadingAnchor.constraint(equalTo: a.leadingAnchor),
                date.trailingAnchor.constraint(equalTo: a.trailingAnchor),
                date.bottomAnchor.constraint(equalTo: a.bottomAnchor)
            ])
        }
        last!.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        return view
    }
}

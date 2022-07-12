//
//  ViewController.swift
//  day1
//
//  Created by hello on 2022/6/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.nameLabel.text = datas[indexPath.row].name + "\(indexPath.row)"
        cell.timeLabel.text = datas[indexPath.row].time
        return cell
    }
    
    var datas : [Data] = []
    var isClick = false
    var ms : Int = 0
    var timer : Timer!
    
    let timerLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let stop : UIButton = {
        let button = UIButton()
        button.setTitle("开始", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    let reset : UIButton = {
        let button = UIButton()
        button.setTitle("停止", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.layer.cornerRadius = button.frame.width/2
        return button
        
    }()
    
    let records:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        return table
    }()
    let containView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.safeAreaLayoutGuide.owningView?.backgroundColor = .black
        //设置数据来源？
        records.dataSource = self
        //设置单元格样式，并设置识别的相关标语
        records.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(timerLabel)
        containView.addSubview(stop)
        containView.addSubview(reset)
        view.addSubview(containView)
        view.addSubview(records)
        
        timerLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        timerLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,multiplier: 0.25).isActive = true
        
        NSLayoutConstraint.activate([
            containView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.25),
            containView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor)
        ])
        
        stop.topAnchor.constraint(equalTo: containView.topAnchor).isActive = true
        stop.heightAnchor.constraint(equalTo: containView.heightAnchor).isActive = true
        stop.widthAnchor.constraint(equalTo: stop.heightAnchor).isActive = true
        stop.leadingAnchor.constraint(equalTo: containView.leadingAnchor).isActive = true
        stop.layer.cornerRadius = view.frame.height * 0.125
        
        NSLayoutConstraint.activate([
            reset.widthAnchor.constraint(equalTo: stop.widthAnchor),
            reset.heightAnchor.constraint(equalTo: stop.heightAnchor),
            reset.centerYAnchor.constraint(equalTo: stop.centerYAnchor),
            reset.leadingAnchor.constraint(greaterThanOrEqualTo:stop.trailingAnchor,constant: 10),
            reset.trailingAnchor.constraint(equalTo: containView.trailingAnchor)
        ])
        reset.layer.cornerRadius = view.frame.height * 0.125
        
        NSLayoutConstraint.activate([
            records.topAnchor.constraint(equalTo: containView.bottomAnchor),
            records.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            records.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            records.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        
        stop.addTarget(self, action: #selector(timerStop(button:)), for: .touchUpInside)
        
        reset.addTarget(self, action: #selector(restartTimer(button:)), for: .touchUpInside)
        
    }
    
    @objc func timerStop(button : UIButton){
        print(button.tag)
        if(!isClick){
            isClick = true
            self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(getTime), userInfo: nil, repeats: true)
            stop.setTitle("添加", for: .normal)
            stop.isUserInteractionEnabled = false
            reset.isUserInteractionEnabled = true
        } else {
            isClick = false
            add()
            resetTime()
            stop.setTitle("开始", for: .normal)
            stop.isUserInteractionEnabled = false
            reset.isUserInteractionEnabled = true
        }
    }
    
    @objc func restartTimer(button:UIButton){
        if(isClick){
            isClick = false
            reset.setTitle("重置", for: .normal)
            stop.isUserInteractionEnabled = true
            reset.isUserInteractionEnabled = false
            add()
            resetTime()
        } else {
            resetTime()
            stop.setTitle("开始", for: .normal)
            reset.setTitle("停止", for: .normal)
            reset.isUserInteractionEnabled = true
            stop.isUserInteractionEnabled = true
        }
    }
        
    private func add(){
        var data = Data()
        data.name = "记录"
        data.time = String(format: "%02d:%02d:%02d", ms / 6000, (ms/100) % 60 , ms % 100)
        datas.append(data)
        records.reloadData()
    }
    
    private func resetTime(){
        ms = 0
        timerLabel.text = String(format: "%02d:%02d:%02d", ms / 6000, (ms/100) % 60 , ms % 100)
    }
        
    
    @objc func getTime(){
        if isClick{
            ms += 1
        }
        timerLabel.text = String(format: "%02d:%02d:%02d", ms / 6000, (ms/100) % 60 , ms % 100)
    }

}


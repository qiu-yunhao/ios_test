//
//  ViewController.swift
//  Day3
//
//  Created by hello on 2022/7/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        let tomato = TomatoClick()
        tomato.timeTotal = 10
        tomato.font = .systemFont(ofSize: 30)
        view.addSubview(tomato)
        tomato.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tomato.widthAnchor.constraint(equalTo: view.widthAnchor),
            tomato.heightAnchor.constraint(equalTo: tomato.widthAnchor),
            tomato.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tomato.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        tomato.startCountDown()
    }


}


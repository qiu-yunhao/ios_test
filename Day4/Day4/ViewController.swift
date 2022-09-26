//
//  ViewController.swift
//  Day4
//
//  Created by hello on 2022/9/13.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var  bannerView: UIBannerView = {
        let bannerView = UIBannerView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.viewController = self
        return bannerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViewLayout()
    }
    
    func initViewLayout() {
        view.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.25),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }


}


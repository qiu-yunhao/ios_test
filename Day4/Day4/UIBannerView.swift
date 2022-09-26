//
//  UIBannerView.swift
//  Day4
//
//  Created by hello on 2022/9/13.
//

import UIKit
import Alamofire
import SwiftyJSON
class UIBannerView : UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    private var dates: [Banner] = [Banner]()
    weak var viewController: UIViewController? = nil
    
    
    private lazy var bannerView: UICollectionView = {
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
       // a.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let section = NSCollectionLayoutSection(group: group)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let a = UICollectionViewCompositionalLayout(section: section, configuration: config)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: a)
        view.isPagingEnabled = true
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadMessage()
        initViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadMessage()
        initViewLayout()
    }
    
    
    func initViewLayout() {
        self.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: self.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bannerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
        
    
    func loadMessage() {
        AF.request("http://ccnubox.muxixyz.com/api/ios/banner/", method: .get).responseDecodable(of: [Banner].self) { (response) in
            switch response.result {
            case .success:
                self.dates = response.value!
                self.bannerView.reloadData()
            case .failure:
                debugPrint("失败了")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.bind(banner: dates[indexPath.row])
        cell.viewController = self.viewController
        let tap = UITapGestureRecognizer(target: cell, action: #selector(cell.jumpToWebView))
        tap.numberOfTouchesRequired = 1
        cell.addGestureRecognizer(tap)
        return cell
    }
    
}


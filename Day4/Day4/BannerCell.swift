//
//  BannerCell.swift
//  Day4
//
//  Created by hello on 2022/9/13.
//

import Foundation
import UIKit
import AlamofireImage
class BannerCell: UICollectionViewCell {
    private var web: String? = nil
    weak var viewController: UIViewController? = nil
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViewLayout()
    }
    
    private func initViewLayout() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func bind(banner: Banner) {
        let url = URL(string: banner.img!)!
        imageView.af.setImage(withURL: url)
        web = banner.url
    }
    
    @objc func jumpToWebView() {
        let web = WebViewCotroller()
        web.data = self.web ?? ""
        viewController?.present(web, animated: true, completion: nil)
    }
}

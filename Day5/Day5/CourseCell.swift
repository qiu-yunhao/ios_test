//
//  CourseCell.swift
//  Day5
//
//  Created by hello on 2022/9/14.
//

import Foundation
import UIKit
class CourseCell : UITableViewCell,UIScrollViewDelegate {
    
    weak var headView: UIScrollView? = nil
    
    private let number: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let time: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    lazy var scrollList: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .cyan
        return scrollView
    }()
    
    private let colors = [UIColor.green,UIColor.red,UIColor.orange,UIColor.blue]
    
    private var stackView : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        initLayout()
        var last: UIView? = nil
        for i in 0...6 {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = colors[i % colors.count]
            stackView.addSubview(view)
            view.widthAnchor.constraint(equalToConstant: 50).isActive = true
            view.heightAnchor.constraint(equalTo: scrollList.heightAnchor).isActive = true
            if(last == nil) {
                view.leadingAnchor.constraint(equalTo: scrollList.leadingAnchor).isActive = true
            } else {
                view.leadingAnchor.constraint(equalTo: last!.trailingAnchor).isActive = true
            }
            last = view
        }
        last!.trailingAnchor.constraint(equalTo: scrollList.trailingAnchor).isActive = true
        
        
    }
    
    private func initLayout() {
        scrollList.addSubview(stackView)
        contentView.addSubview(scrollList)
        contentView.addSubview(time)
        contentView.addSubview(number)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 45),
            number.topAnchor.constraint(equalTo: contentView.topAnchor),
            number.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            number.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            number.widthAnchor.constraint(equalToConstant: 50),
            
            time.topAnchor.constraint(equalTo: number.bottomAnchor),
            time.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            time.leadingAnchor.constraint(equalTo: number.leadingAnchor),
            time.trailingAnchor.constraint(equalTo: number.trailingAnchor),
            
            scrollList.leadingAnchor.constraint(equalTo: number.trailingAnchor),
            scrollList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollList.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollList.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollList.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollList.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    func bind(title: Course_Title) {
        self.number.text = String(title.number)
        self.time.text = title.time
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if( headView != nil && scrollView == self.scrollList) {
            let offset = scrollView.contentOffset.x
            headView?.contentOffset.x = offset
        }
    }
    
    @objc func moveWithHeadView(_ notifaction: Notification) {
        let dict = notifaction.userInfo as? NSDictionary
        if dict != nil {
            let offset = dict!["offset"] as! CGFloat
            scrollList.contentOffset.x = offset
        }
    }
}

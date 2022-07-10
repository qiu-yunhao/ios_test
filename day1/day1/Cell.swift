//
//  Cell.swift
//  day1
//
//  Created by hello on 2022/6/27.
//

import Foundation
import UIKit

class Cell: UITableViewCell{
    let nameLabel : UILabel = {
        let u = UILabel()
        u.font = UIFont.boldSystemFont(ofSize: 30)
        u.textColor = .white
        u.translatesAutoresizingMaskIntoConstraints = false
        u.textAlignment = .center
        return u
    }();
    let timeLabel : UILabel = {
        let u = UILabel()
        u.textColor = .white
        u.translatesAutoresizingMaskIntoConstraints = false
        u.font = UIFont.boldSystemFont(ofSize: 20)
        u.textAlignment = .center
        return u
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        self.addSubview(nameLabel)
        self.addSubview(timeLabel)
        //contentView.backgroundColor = .black
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            timeLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            timeLabel.leadingAnchor.constraint(greaterThanOrEqualTo:  nameLabel.trailingAnchor,constant: 10),
            //timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}

//
//  Store.swift
//  day1
//
//  Created by hello on 2022/7/10.
//

import Foundation
class Store{
    public static func getDatas() -> [Data]{
        var data : [Data] = []
        for i in 0...10{
            let d = Data(time: "时间\(i)", name: "记录\(i)")
            data.append(d)
        }
        return data
        
    }
    
}

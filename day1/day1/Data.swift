//
//  Data.swift
//  day1
//
//  Created by hello on 2022/6/27.
//

import Foundation

//用于储存每个数据

struct Data{
    var time : String
    var name : String
    
    init(){
        time = ""
        name = ""
    }
    
    init(time: String,name : String){
        self.time = time
        self.name = name
    }
}

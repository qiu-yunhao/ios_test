//
//  Store.swift
//  Day5
//
//  Created by hello on 2022/9/15.
//

import Foundation

struct Course_Title {
    var time:String? = nil
    var number = 0
}

class Store {
    private let times = ["8:00", "10:10", "14:00","16:10","18:30","20:15"]
    func getCourses() -> [Course_Title] {
        var ans = [Course_Title]()
        for i in 1...12 {
            if( i % 2 == 0) {
                ans.append(Course_Title(time: "", number: i))
            } else {
                ans.append(Course_Title(time: times[i/2], number: i))
            }
        }
        return ans
    }
}

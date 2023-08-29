//
//  TreePerson.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/26.
//

import Foundation

class TreePerson: Comparable {
    var age: Int = 0
    var name: String = ""
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    static func == (lhs: TreePerson, rhs: TreePerson) -> Bool {
        return lhs.age == rhs.age
    }
    
    static func < (lhs: TreePerson, rhs: TreePerson) -> Bool {
        return lhs.age < rhs.age
    }
}

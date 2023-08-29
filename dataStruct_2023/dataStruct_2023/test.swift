//
//  test.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/19.
//

import Foundation

protocol interface {
    associatedtype E
    var NS_NOT_FOUND: Int {get}
    /// 返回某个元素的位置
    func indexOf<E: Equatable>(element: E) -> Int
}

class node<E: Equatable> {
    var element: E
    init(element: any Equatable) {
        self.element = element as! E
    }
    static func == (lhs: node, rhs: node) -> Bool {
        return lhs.element == rhs.element
    }
}

class list<E: Equatable>: interface {
    let NS_NOT_FOUND: Int = -1
    var head: node<E>?
    init() {
    }
    func indexOf<E>(element: E) -> Int where E : Equatable {
//        let temp: node = node<E>(element: element)
//        if head! == temp {
//            return 1
//        }
        return NS_NOT_FOUND
    }
}



//
//  List.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/14.
//
//  链表的基类

import Foundation
enum MyError: Error {
    case outOfBounds
}

class List<E: Equatable>: ListInterface {
    var NS_NOT_FOUND: Int = -1
    var _size: Int = 0
    func size() -> Int {
        return _size
    }
    
    func isEmpty() -> Bool {
        return size() == 0
    }
    
    func clear() {
        _size = 0
    }
    
    func contains(element: E) -> Bool {
        return indexOf(element: element) != NS_NOT_FOUND
    }
    
    func add(element: E) {
        add(index: size(), element: element)
    }
    
    func add(index: Int, element: E) {
        assert(false, "必须由子类实现");
    }
    
    func get(index: Int) -> E? {
        assert(false, "必须由子类实现");
        return nil
    }
    
    func set(index: Int, element: E) -> E? {
        assert(false, "必须由子类实现");
        return nil
    }
    
    func remove(index: Int) -> E? {
        assert(false, "必须由子类实现");
        return nil
    }
    
    func indexOf<E: Equatable>(element: E) -> Int where E : Equatable {
        assert(false, "必须由子类实现");
        return NS_NOT_FOUND
    }
    
    func outOfBounds(index: Int) -> Bool {
        if (index < 0 || index >= size()) {
            print("outOfBounds")
            return true
        }
        return false
    }
    
    func outOfAddBounds(index: Int) -> Bool {
        if (index < 0 || index > size()) {
            print("outOfAddBounds")
            return true
        }
        return false
    }
}

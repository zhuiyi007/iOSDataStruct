//
//  DynamicArray.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/13.
//

/*
int size (); 1/元素的数量
boolean isEmpty()；1/是否为空
boolean contains(E element);1/是否包含某个元素
void add (E element);1/添加元素到最后面
E get (int index);1/返回index位置对应的元素
E set(int index, E element);1/设置index位置的元素
void add(int index， E element)； 1/往index位置添加元素
E remove (int index);1删除index位置对应的元素
int indexof(E element)；/1查看元素的位置
void clear ();清除所有元素
 */

import Foundation

class DynamicArray: CustomStringConvertible {
    
    let NS_NOT_FOUND = -1
    private var count: Int
    private var array: [Int]
    
    init() {
        count = 0
        array = []
    }
    
    var description: String {
        return "\(array)"
    }
    
    func size() -> Int {
        return count
    }
    func isEmpty() -> Bool {
        return count == 0
    }
    func contains(element: Int) -> Bool {
        return indexOf(element: element) != NS_NOT_FOUND
    }
    func add(element: Int) {
        array[size()] = element
        count += 1
    }
    func get(index: Int) -> Int {
        if (index < 0 || index >= size()) {
            assert(false, "index: \(index), size: \(size())")
        }
        return array[index]
    }
    func replace(index: Int, element: Int) -> Int {
        if (index < 0 || index >= size()) {
            assert(false, "index: \(index), size: \(size())")
        }
        let old = array[index]
        array[index] = element
        return old
    }
    func inset(index: Int, element: Int) {
        
    }
    func remove(index: Int) -> Int {
        return 0
    }
    func indexOf(element: Int) -> Int {
        for i in (0..<size()) {
            if (array[i] == element) {
                return i
            }
        }
        return NS_NOT_FOUND
    }
    func clear() {
        count = 0
    }
}

//
//  DoublyLinkList.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/18.
//
//  双向链表

import Foundation

class DoublyNode<E: Equatable>: Equatable, CustomStringConvertible {
    var element: E
    /// 避免循环引用
    weak var prev: DoublyNode<E>?
    var next: DoublyNode<E>?
    init(element: any Equatable, prev: DoublyNode<E>? = nil, next: DoublyNode<E>? = nil) {
        self.element = element as! E
        self.prev = prev
        self.next = next
    }
    deinit {
        print("DoublyNode - \(element) - deinit")
    }
    static func == (lhs: DoublyNode, rhs: DoublyNode) -> Bool {
        return lhs.element == rhs.element
    }
    
    var description: String {
        let prevDesc = self.prev == nil ? "nil" : String(describing: self.prev!.element)
        let nextDesc = self.next == nil ? "nil" : String(describing: self.next!.element)
        
        return "\(prevDesc)_\(self.element)_\(nextDesc)"
    }
}

class DoublyLinkList<E: Equatable>: List<E>, CustomStringConvertible {
    
    private var first: DoublyNode<E>?
    private var last: DoublyNode<E>?
    override init() {
    }
    
    var description: String {
        var string = "size: \(size()) ["
        var currentNode: DoublyNode<E>? = first
        while (currentNode != nil) {
            string.append("\(currentNode!), ")
            currentNode = currentNode?.next
        }
        string.append("]")
        return string
    }
    
    override func clear() {
        first = nil
        last = nil
        _size = 0
    }
    
    override func add(index: Int, element: E) {
        if outOfAddBounds(index: index) {
            return
        }
        let tempNode = DoublyNode<E>(element: element)
        if index == size() {
            last?.next = tempNode
            tempNode.prev = last
            last = tempNode
        } else {
            /// 新添加节点的下一个
            let node = node(index: index)
            tempNode.next = node
            tempNode.prev = node?.prev
            
            tempNode.prev?.next = tempNode
            tempNode.next?.prev = tempNode
        }
        if index == 0 {
            first = tempNode
        }
        
        _size += 1
    }
    
    override func get(index: Int) -> E? {
        return node(index: index)?.element
    }
    
    override func set(index: Int, element: E) -> E? {
        let node = node(index: index)
        let tempE = node?.element
        node?.element = element
        return tempE
    }
    
    override func remove(index: Int) -> E? {
        let node = node(index: index)
        if index == 0 {
            first = node?.next
        }
        if index == size() - 1 {
            last = node?.prev
        }
        node?.prev?.next = node?.next
        node?.next?.prev = node?.prev
        
        node?.prev = nil
        node?.next = nil
        _size -= 1
        return node?.element
    }
    
    override func indexOf<E: Equatable>(element: E) -> Int  where E : Equatable {
        if size() == 0 {
            return NS_NOT_FOUND
        }
        var currentNode = first
        for i in 0..<size() {
            if currentNode! == DoublyNode(element: element) {
                return i
            }
            currentNode = currentNode!.next
        }
        return NS_NOT_FOUND
    }
    
    private func node(index: Int) -> DoublyNode<E>? {
        if outOfBounds(index: index) {
            return nil
        }
        var node: DoublyNode<E>?
        if index < size() >> 1 {
            /// 前一半的数据
            node = first
            for _ in 0..<index {
                node = node?.next
            }
        } else {
            /// 后一半的数据
            node = last
            for _ in (index..<size() - 1).reversed() {
                node = node?.prev
            }
        }
        return node
    }
}

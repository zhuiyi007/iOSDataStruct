//
//  LinkList.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/14.
//
//  单向链表

import Foundation

class Node<E: Equatable>: CustomStringConvertible {
    var element: E
    var next: Node<E>?
    init(element: any Equatable, next: Node<E>? = nil) {
        self.element = element as! E
        self.next = next
    }
    deinit {
        print("Node - \(element) - deinit")
    }
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.element == rhs.element
    }
    
    var description: String {
        let nextDesc = self.next == nil ? "nil" : String(describing: self.next!.element)
        
        return "\(self.element)_\(nextDesc)"
    }
}

class LinkList<E: Equatable>: List<E>, CustomStringConvertible {
    
    private var head: Node<E>?
    override init() {
    }
    
    var description: String {
        var string = "size: \(size()) ["
        var currentNode: Node<E>? = head
        while (currentNode != nil) {
            string.append("\(currentNode!), ")
            currentNode = currentNode?.next
        }
        string.append("]")
        return string
    }
    
    override func clear() {
        head = nil
        _size = 0
    }
    
    override func add(index: Int, element: E) {
        let tempNode = Node<E>(element: element)
        if index == 0 {
            tempNode.next = head
            head = tempNode
        } else {
            let node = node(index: index - 1)
            tempNode.next = node?.next
            node?.next = tempNode
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
        var tempE = head?.element
        if index == 0 {
            head = head?.next
        } else {
            let node = node(index: index - 1)
            tempE = node?.next?.element
            node?.next = node?.next?.next
        }
        _size -= 1
        return tempE
    }
    
    override func indexOf<E>(element: E) -> Int where E : Equatable {
        if size() == 0 {
            return NS_NOT_FOUND
        }
        var currentNode = head
        for i in 0..<size() {
            if currentNode! == Node(element: element) {
                return i
            }
            currentNode = currentNode!.next
        }
        return NS_NOT_FOUND
    }
    
    private func node(index: Int) -> Node<E>? {
        if outOfBounds(index: index) {
            return nil
        }
        var node = head
        for _ in 0..<index {
            node = node?.next
        }
        return node
    }
}

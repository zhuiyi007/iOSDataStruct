//
//  LoopDoublyLinkList.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/19.
//
// 循环双向链表

import Foundation

class LoopDoublyLinkList<E: Equatable>: List<E>, CustomStringConvertible {
    
    private var first: DoublyNode<E>?
    private var last: DoublyNode<E>?
    private var current: DoublyNode<E>?
    override init() {
    }
    
    var description: String {
        var string = "size: \(size()) ["
        var currentNode: DoublyNode<E>? = first
        for _ in 0..<size() {
            string.append("\(currentNode!), ")
            currentNode = currentNode?.next
        }
        string.append("]")
        return string
    }
    
    // MARK: - Josephus Interface
    /// 重置current节点
    func reset() {
        current = first
    }
    
    /// 删除current节点的内容
    func deleteCurrent() -> E? {
        let index = indexOf(element: current?.element)
        goNext()
        return remove(index: index)
    }
    
    /// current后移一步
    func goNext() {
        current = current?.next
    }
    
    // MARK: - public func
    override func clear() {
        // 断开一条循环链表的线,让节点正常释放
        first?.next = nil
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
            // 往末尾插入节点
            last?.next = tempNode
            tempNode.prev = last
            // 尾结点的next指向头结点
            tempNode.next = first
            // 头结点的prev指向新插入的节点
            first?.prev = tempNode
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
            // 往头结点插入元素
            first = tempNode
            // 此处处理了空链表首次添加的情况
            // 尾结点的next指向头结点
            last?.next = first
            // 头结点的prev指向尾结点
            first?.prev = last
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
        if outOfBounds(index: index) {
            return nil
        }
        // 找到当前位置的元素
        let node = node(index: index)
        if index == 0 {
            // 删除头结点元素
            first = node?.next
            // 尾结点的next指向头结点
            last?.next = first
            // 头结点的prev指向尾结点
            first?.prev = last
        }
        if index == size() - 1 {
            // 删除尾结点元素
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
    
    // MARK: - private func
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

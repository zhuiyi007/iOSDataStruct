//
//  LoopLinkList.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/19.
//
// 单向循环链表

import Foundation

class LoopLinkList<E: Equatable>: List<E>, CustomStringConvertible {

    private var head: Node<E>?
    override init() {
    }

    var description: String {
        var string = "size: \(size()) ["
        var currentNode: Node<E>? = head
        for _ in 0..<size() {
            string.append("\(currentNode!), ")
            currentNode = currentNode?.next
        }
        string.append("]")
        return string
    }

    override func clear() {
        // 需要断开一条循环链表中的线
        head?.next = nil
        head = nil
        _size = 0
    }

    override func add(index: Int, element: E) {
        if outOfAddBounds(index: index) {
            // 越界
            return
        }
        // 初始化一个节点,默认next指向头结点
        let tempNode = Node(element: element, next: head)
        if index == 0 {
            // 往头结点插入元素
            // 找到最后一个节点
            let lastNode = node(index: size() - 1)
            head = tempNode
            // 变更最后一个节点的next指向头结点
            if lastNode == nil {
                // 没有尾结点,证明链表为空
                tempNode.next = tempNode
            } else {
                lastNode?.next = head
            }
        } else if index == size() {
            // 往尾结点插入元素
            let lastNode = node(index: size() - 1)
            lastNode?.next = tempNode
        } else {
            // 通用情况
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
        if outOfBounds(index: index) {
            return nil
        }
        if size() == 1 {
            // 只有一个元素
            head?.next = nil
            head = nil
        }
        var tempE = head?.element
        if index == 0 {
            // 删除头结点元素
            // 找到末尾元素
            let lastNode = node(index: size() - 1)
            lastNode?.next = head?.next
            head = head?.next
        } else {
            // 通用情况
            // 其中包含了删除尾结点的情况
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

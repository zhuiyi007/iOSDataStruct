//
//  RBTree.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/8/29.
//

import Foundation
let RED = false
let BLACK = true
class RBTreeNode<E>: BinaryTreeNode<E> {
    var _color = RED
    
    /// 是否是红色
    func isRed() -> Bool {
        return _color == RED
    }
    
    /// 是否是黑色
    func isBlack() -> Bool {
        return _color == BLACK
    }
    
    /// 染色
    func colouration(color: Bool) -> RBTreeNode<E> {
        _color = color
    }
    
    
    /// 染成红色
    func red() -> RBTreeNode<E> {
        _color = RED
        return self
    }
    
    /// 染成黑色
    func black() -> RBTreeNode<E> {
        _color = BLACK
        return self
    }
    
    /// 兄弟节点
    func sibling() -> RBTreeNode<E>? {
        if (isLeftChild()) {
            return parent?.right
        }
        if (isRightChild()) {
            return parent?.left
        }
        return nil
    }
    override var description: String {
        return "\(element)_\(String(describing: parent?.element))_\(_color)"
    }
}
class RBTree<E: Comparable>: BinaryBalanceSearchTree<E> {
    
}

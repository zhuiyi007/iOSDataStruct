//
//  RBTree.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/8/29.
//

import Foundation
let RED = true
let BLACK = false
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
        return self
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
            return parent!.right as? RBTreeNode<E>
        }
        if (isRightChild()) {
            return parent!.left as? RBTreeNode<E>
        }
        return nil
    }
    override var description: String {
        return "\(element)_\(_color ? "R" : "B")"
    }
}
class RBTree<E: Comparable>: BinaryBalanceSearchTree<E> {
    
    override func add(element: E) {
        if self.checkIsNull(element: element) {
            return
        }
        let addNode = RBTreeNode(element: element)
        add(element: addNode)
    }
    
    override func afterAdd(node: BinaryTreeNode<E>) {
        var rbNode = node as! RBTreeNode<E>
        if rbNode.parent == nil {
            /// 根节点
            /// 染成黑色
            rbNode.black()
            return
        }
        if (rbNode.parent as! RBTreeNode).isBlack() {
            /// 父节点是黑色
            /// 不用做任何处理
            return
        }
        /// 能来到这里,说明父节点是红色
        let parent = rbNode.parent as! RBTreeNode<E>
        let uncle = parent.sibling()
        let grand = (parent.parent as! RBTreeNode<E>).red()
        if uncle == nil || uncle!.isBlack() {
            /// 叔父节点为空,或者叔父节点是黑色
            if parent.isLeftChild() {
                /// L
                if rbNode.isLeftChild() {
                    /// LL
                    parent.black()
                } else {
                    /// LR
                    rbNode.black()
                    rotateLeft(grand: parent)
                }
                rotateRight(grand: grand)
            } else {
                /// R
                if rbNode.isLeftChild() {
                    /// RL
                    rbNode.black()
                    rotateRight(grand: parent)
                } else {
                    /// RR
                    parent.black()
                }
                rotateLeft(grand: grand)
            }
            return
        }
        
        /// 能来到这里,说明叔父节点是红色
        /// parent染成黑色
        parent.black()
        /// uncle染成黑色
        uncle!.black()
        /// grand当做新添加的节点进行处理
        afterAdd(node: grand)
    }
}

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
        return "\(element)\(_color ? "_R" : "")"
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
    
    override func afterRemove(node: BinaryTreeNode<E>, replaceNode: BinaryTreeNode<E>?) {
        var rbNode = node as! RBTreeNode<E>
        var rbReplaceNode = replaceNode as? RBTreeNode<E>
        if rbNode.isRed() {
            /// 如果删除的节点是红色,则不需要做任何处理
            return
        }
        /// 删除的节点是黑色节点
        /// 替代它的是红色节点
        if rbReplaceNode != nil && rbReplaceNode!.isRed() {
            /// 则直接将他染黑即可
            rbReplaceNode = rbReplaceNode!.black()
            return
        }
        
        if rbNode.parent == nil {
            return
        }
        
        var parent = rbNode.parent as! RBTreeNode<E>
        var sibling = (parent.left == nil ? parent.right : parent.left) as! RBTreeNode<E>
        
        if sibling.isRed() {
            /// 兄弟节点是红色
            /// 先染色,后旋转
            /// 然后就会转化成兄弟节点是黑色的情况
            sibling = sibling.black()
            parent = parent.red()
            if sibling.isLeftChild() { /// LL
                rotateRight(grand: parent)
            } else { /// RR
                rotateLeft(grand: parent)
            }
        }
        
        parent = rbNode.parent as! RBTreeNode<E>
        sibling = (parent.left == nil ? parent.right : parent.left) as! RBTreeNode<E>
        var left = sibling.left as? RBTreeNode<E>
        var right = sibling.right as? RBTreeNode<E>
        
        /// 能来到这里
        /// 兄弟节点一定是黑色
        if (left != nil && left!.isRed()) || (right != nil && right!.isRed()) {
            /// 兄弟节点的子节点中至少有一个红色节点
            let parentColor = (parent as! RBTreeNode)._color
            if sibling.isLeftChild() { /// L
                /// 做对应的旋转
                if left != nil && left!.isRed() { /// LL
                    /// 因为又可能兄弟节点有两个红色子节点
                    /// 此处先判断同方向的
                    /// 如果条件满足,则只需要旋转一次
                    rotateRight(grand: parent)
                    parent = sibling
                } else { /// LR
                    rotateLeft(grand: sibling)
                    rotateRight(grand: parent)
                    parent = sibling.parent as! RBTreeNode
                }
            } else { /// R
                /// 做对应的旋转
                if right != nil && right!.isRed() { /// RR
                    /// 因为又可能兄弟节点有两个红色子节点
                    /// 此处先判断同方向的
                    /// 如果条件满足,则只需要旋转一次
                    rotateLeft(grand: parent)
                    parent = sibling
                } else { /// RL
                    rotateRight(grand: sibling)
                    rotateLeft(grand: parent)
                    parent = sibling.parent as! RBTreeNode
                }
            }
            /// 原先的兄弟节点会转上去作为父节点
            /// 父节点染色为原来父节点的颜色
            parent.colouration(color: parentColor)
            /// 左右节点染成黑色
            (parent.left as? RBTreeNode)?.black()
            (parent.right as? RBTreeNode)?.black()
        } else {
            /// 能走到这里
            /// 说明兄弟节点没有红色子节点
            /// 保存一下父节点的颜色
            let parentColor = parent._color
            /// 将父节点染黑,兄弟节点染红即可
            sibling = sibling.red()
            parent = parent.black()
            /// 如果父节点也是黑色
            /// 则证明父节点也要下溢,将父节点当做删除的节点重新处理一遍即可
            if parentColor == BLACK {
                afterRemove(node: parent, replaceNode: nil)
                return
            }
        }
    }
}

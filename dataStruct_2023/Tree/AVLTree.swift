//
//  AVLTree.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/8/21.
//

import Foundation

class AVLTreeNode<E>: BinaryTreeNode<E> {
    var height = 1
    func isBalance() -> Bool {
        let leftHeight = left == nil ? 0 : (left as! AVLTreeNode).height
        let rightHeight = right == nil ? 0 : (right as! AVLTreeNode).height
        return abs(leftHeight - rightHeight) <= 1
    }
    func updateHeight() {
        let leftHeight = left == nil ? 0 : (left as! AVLTreeNode).height
        let rightHeight = right == nil ? 0 : (right as! AVLTreeNode).height
        height = max(leftHeight, rightHeight) + 1
    }
    func tallerChild() -> AVLTreeNode<E> {
        let leftHeight = left == nil ? 0 : (left as! AVLTreeNode).height
        let rightHeight = right == nil ? 0 : (right as! AVLTreeNode).height
        return (leftHeight > rightHeight ? left : right) as! AVLTreeNode<E>
    }
    
    override var description: String {
        return "\(element)_\(String(describing: parent?.element))_\(height)"
    }
}

class AVLTree<E: Comparable>: BinaryBalanceSearchTree<E> {
    
    override func add(element: E) {
        if self.checkIsNull(element: element) {
            return
        }
        let addNode = AVLTreeNode(element: element)
        add(element: addNode)
    }
    
    /*
     添加失衡和删除失衡的不同:
     添加可能导致高度最低的失衡节点往上的所有祖先节点都失衡,但是只需要调整高度最低的失衡节点后,整棵树就会恢复平衡(仅需O(1)次调整)
     删除只可能导致父节点或祖父节点失衡,但是在调整完后,又可能导致上层的节点失衡,因此,需要一路往上检查所有的节点(最多需要O(log(n)次调整))
     */
    override func afterAdd(node: BinaryTreeNode<E>) {
        var avlTreeNode = node.parent as? AVLTreeNode
        while avlTreeNode != nil {
            /// 往上找
            /// 找到第一个失衡的节点
            if (avlTreeNode!.isBalance()) {
                /// 平衡的
                /// 更新高度
                avlTreeNode!.updateHeight()
                /// 更新节点
                avlTreeNode = avlTreeNode!.parent as? AVLTreeNode
            } else {
                /// 当前节点失衡了
                /// 恢复平衡
                rebalanceTree(node: avlTreeNode!)
                break
            }
        }
    }
    
    override func afterRemove(node: BinaryTreeNode<E>, replaceNode: BinaryTreeNode<E>?) {
        var avlTreeNode = node.parent as? AVLTreeNode
        while avlTreeNode != nil {
            /// 往上找
            /// 找到第一个失衡的节点
            if (avlTreeNode!.isBalance()) {
                /// 平衡的
                /// 更新高度
                avlTreeNode!.updateHeight()
                /// 更新节点
                avlTreeNode = avlTreeNode!.parent as? AVLTreeNode
            } else {
                /// 当前节点失衡了
                /// 恢复平衡
                rebalanceTree(node: avlTreeNode!)
            }
        }
    }
    
    /// V1版本,根据不同情况分别进行左旋和右旋
    func rebalanceTree1(node: AVLTreeNode<E>) {
        /// node为最底层失衡的节点
        /// 先找到三级祖父节点
        let grand = node
        /// 父节点为祖父节点子节点中更高的那个
        let parent = grand.tallerChild()
        /// 子节点为父节点的子节点中更高的那个
        let child = parent.tallerChild()
        if parent.isLeftChild() {
            /// L
            if child.isLeftChild() {
                /// LL
                rotateRight(grand: grand)
            } else {
                /// LR
                rotateLeft(grand: parent)
                rotateRight(grand: grand)
            }
        } else {
            /// R
            if child.isLeftChild() {
                /// RL
                rotateRight(grand: parent)
                rotateLeft(grand: grand)
            } else {
                /// RR
                rotateLeft(grand: grand)
            }
        }
    }
    
    override func afterRotate(grand: BinaryTreeNode<E>, parent: BinaryTreeNode<E>, child: BinaryTreeNode<E>?) {
        super.afterRotate(grand: grand, parent: parent, child: child)
        
        let avlGrand = grand as! AVLTreeNode<E>
        let avlParent = parent as! AVLTreeNode<E>
        /// 从底层开始往上更新高度
        avlGrand.updateHeight()
        avlParent.updateHeight()
    }
    
    /// V2版本,提前组织好a-g节点,进行统一的旋转操作
    func rebalanceTree(node: AVLTreeNode<E>) {
        /// node为最底层失衡的节点
        /// 先找到三级祖父节点
        let grand = node
        /// 父节点为祖父节点子节点中更高的那个
        let parent = grand.tallerChild()
        /// 子节点为父节点的子节点中更高的那个
        let child = parent.tallerChild()
        if parent.isLeftChild() {
            /// L
            if child.isLeftChild() {
                /// LL
                rotate(root: grand, b: child, c: child.right as? AVLTreeNode<E>, d: parent, e: parent.right as? AVLTreeNode<E>, f: grand)
            } else {
                /// LR
                rotate(root: grand, b: parent, c: child.left as? AVLTreeNode<E>, d: child, e: child.right as? AVLTreeNode<E>, f: grand)
            }
        } else {
            /// R
            if child.isLeftChild() {
                /// RL
                rotate(root: grand, b: grand, c: child.left as? AVLTreeNode<E>, d: child, e: child.right as? AVLTreeNode<E>, f: parent)
            } else {
                /// RR
                rotate(root: grand, b: grand, c: parent.left as? AVLTreeNode<E>, d: parent, e: child.left as? AVLTreeNode<E>, f: child)
            }
        }
    }
    
    override func rotate(root: BinaryTreeNode<E>, b: BinaryTreeNode<E>, c: BinaryTreeNode<E>?, d: BinaryTreeNode<E>, e: BinaryTreeNode<E>?, f: BinaryTreeNode<E>) {
        super.rotate(root: root, b: b, c: c, d: d, e: e, f: f)
        
        let avlB = b as! AVLTreeNode<E>
        let avlD = d as! AVLTreeNode<E>
        let avlF = f as! AVLTreeNode<E>
        /// 从底层开始往上更新高度
        avlB.updateHeight()
        avlF.updateHeight()
        avlD.updateHeight()
    }
}

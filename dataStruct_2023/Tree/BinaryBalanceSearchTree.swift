//
//  BinaryBalanceSearchTree.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/8/29.
//

import Foundation

class BinaryBalanceSearchTree<E: Comparable>: BinarySearchTree<E> {
    
    func rotate(root: BinaryTreeNode<E>,/* 原先子树的根节点*/
                /*a-g为原节点从左到右依次排序的结果*/
                b: BinaryTreeNode<E>, c: BinaryTreeNode<E>?,
                d: BinaryTreeNode<E>,
                e: BinaryTreeNode<E>?, f: BinaryTreeNode<E>) {
        /// 观察所有的旋转方式,旋转完成后,都是d为根节点,从左到右a-g依次排序
        /// 因此把这几个元素的左右节点以及parent节点维护好即可
        
        /// 首先维护根节点
        d.parent = root.parent
        if root.isLeftChild() {
            root.parent!.left = d
        } else if root.isRightChild() {
            root.parent!.right = d
        } else {
            /// root为根节点
            rootNode = d
        }
        /// 维护左边a-c的节点
        b.right = c
        c?.parent = b
        
        /// 维护右边e-g的节点
        f.left = e
        e?.parent = f
        
        /// 维护d节点
        d.left = b
        d.right = f
        b.parent = d
        f.parent = d
    }
    
    /// 右旋转
    func rotateRight(grand: BinaryTreeNode<E>) {
        let parent = grand.left!
        let child = parent.right
        grand.left = child
        parent.right = grand
        afterRotate(grand: grand, parent: parent, child: child)
    }
    
    /// 左旋转
    func rotateLeft(grand: BinaryTreeNode<E>) {
        let parent = grand.right!
        let child = parent.left
        grand.right = child
        parent.left = grand
        afterRotate(grand: grand, parent: parent, child: child)
    }
    
    func afterRotate(grand: BinaryTreeNode<E>, parent: BinaryTreeNode<E>, child: BinaryTreeNode<E>?) {
        /// 先让parent成为整棵树的根节点
        parent.parent = grand.parent
        /// 维护原有更高级节点的左右子树
        if grand.isLeftChild() {
            grand.parent!.left = parent
        } else if grand.isRightChild() {
            grand.parent!.right = parent
        } else {
            /// 原来grand就是根节点
            rootNode = parent
        }
        
        grand.parent = parent
        
        child?.parent = grand
    }

}

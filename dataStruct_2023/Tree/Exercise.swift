//
//  Exercise.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/8/11.
//

import Foundation

class TreeExercise<E> {
    
    /// 反转二叉树
    func reverseBinaryTree(root: BinaryTreeNode<E>?) -> Void {
        if root == nil {
            return
        }
        let tempNode = root!.left
        root!.left = root!.right
        root!.right = tempNode
        
        reverseBinaryTree(root: root!.left)
        reverseBinaryTree(root: root!.right)
    }
    
    /// 是否是完全二叉树
    func fullBinaryTree(root: BinaryTreeNode<E>?) -> Bool {
        if root == nil {
            /// 根节点为空,直接返回false
            return false
        }
        var queue = [BinaryTreeNode<E>]()
        queue.append(root!)
        /// 标记是否后续节点都为叶子结点
        var isLeaf = false
        while queue.count > 0 {
            /// 层序遍历二叉树
            let node = queue.remove(at: 0)
            if isLeaf && ((node.right != nil) || (node.left != nil)) {
                /// 如果后续节点都需要是叶子结点
                /// 且当前节点不是叶子结点
                /// 直接返回false
                return false
            }
            if node.left != nil {
                /// 左节点不为空
                queue.append(node.left!)
            } else if node.right != nil {
                /// 左节点为空且右节点不为空
                return false
            } else {
                /// 右节点为空
                isLeaf = true
            }
            if node.right != nil {
                queue.append(node.right!)
            }
        }
        return true
    }
    
    /// 返回树的高度
    /// - Parameter root: 根节点
    func treeHeight(root: BinaryTreeNode<E>?) -> Int {
        /// 迭代的方式
        /// 利用层序遍历,遍历完一层,高度+1
        if root == nil {
            return 0
        }
        /// 有根节点,树的初始高度为1
        var height = 0
        /// 有根节点,第一层的节点数量为1
        var levelCount = 1
        var queue = [BinaryTreeNode<E>]()
        queue.append(root!)
        while queue.count > 0 {
            let node = queue.remove(at: 0)
            if node.left != nil {
                queue.append(node.left!)
            }
            if node.right != nil {
                queue.append(node.right!)
            }
            levelCount -= 1
            if levelCount == 0 {
                height += 1
                levelCount = queue.count
            }
        }
        return height
    }
    func treeHeight1(root: BinaryTreeNode<E>?) -> Int {
        // 递归的方式
        if root == nil {
            return 0
        }
        let maxTreeHeight = max(treeHeight(root: root?.left), treeHeight(root: root?.right))
        return maxTreeHeight + 1
    }
}

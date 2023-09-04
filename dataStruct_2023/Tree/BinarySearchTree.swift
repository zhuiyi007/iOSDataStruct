//
//  BinarySearchTree.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/24.
//
// 二叉搜索树
import Foundation

class BinarySearchTree<E: Comparable>: BinaryTree<E> {
    
    override func add(element: BinaryTreeNode<E>) {
        
        let addNode = element
        if size() == 0 {
            // 当前没有节点
            rootNode = addNode
        } else {
            // 当前树中有节点
            var node = rootNode
            var parent = rootNode
            var compareResult = 0
            while node != nil {
                parent = node
                compareResult = self.compare(element1: addNode.element, element2: node!.element)
                if compareResult > 0 {
                    // 传入的元素比当前元素大
                    node = node?.right
                } else if compareResult < 0 {
                    // 传入的元素比当前元素小
                    node = node?.left
                } else {
                    // 传入的元素和当前元素相同
                    node?.element = addNode.element
                }
            }
            // 循环完毕,插入数据
            if compareResult > 0 {
                // 传入的元素比当前元素大
                parent!.right = addNode
            } else if compareResult < 0 {
                // 传入的元素比当前元素小
                parent!.left = addNode
            }
            addNode.parent = parent
        }
        afterAdd(node: addNode)
        _size += 1
    }
    
    /// 添加结束后调用的方法,供子类重写
    func afterAdd(node: BinaryTreeNode<E>) {
        
    }
    
    override func remove(element: E) -> E? {
        var node = node(element: element)
        if node == nil {
            return nil
        }
        let removeElement = node!.element
        if BinarySearchTree.hasTwoChild(node: node) {
            /// 是度为2的节点
            /// 找到这个节点的前驱或后继
//            let precursor = precursor(node: node)
            let precursor = successor(node: node)
            /// 用这个前驱或后继节点直接覆盖要删除的节点
            node!.element = precursor!.element
            /// 覆盖完成后,再删除前驱或后继节点即可
            /// 此处前驱或后继节点一定是叶子节点或度为1的节点
            /// 因此,直接往下走逻辑即可
            node = precursor
        }
        if BinarySearchTree.isLeaf(node: node) {
            /// 是叶子节点
            /// 直接删除此节点
            if node!.parent == nil {
                /// 如果节点没有父节点
                /// 说明要删除的是唯一的根节点
                rootNode = nil
            } else if node!.parent!.left === node {
                /// 要删除的节点是父节点的左子树
                node!.parent!.left = nil
            } else if node!.parent!.right === node {
                /// 要删除的节点是父节点的右子树
                node!.parent!.right = nil
            }
        } else if BinarySearchTree.hasOnlyOneChild(node: node) {
            /// 度为1的节点
            /// 找到这个节点的子节点
            let child = node!.left != nil ? node!.left : node!.right
            if node!.parent == nil {
                /// 要删除的是度为1的根节点
                rootNode = child
            } else if node!.parent!.left === node {
                /// 要删除的节点是父节点的左子树
                node!.parent!.left = child
            } else if node!.parent!.right === node {
                /// 要删除的节点是父节点的右子树
                node!.parent!.right = child
            }
            /// 维护parent指针指向
            child!.parent = node!.parent
        }
        afterRemove(node: node!)
        _size -= 1
        return removeElement
    }
    
    /// 删除结束后调用的方法,供子类重写
    func afterRemove(node: BinaryTreeNode<E>) {
        
    }
    
    override func node(element: E) -> BinaryTreeNode<E>? {
        var node = rootNode
        while node != nil {
            let result = compare(element1: node!.element, element2: element)
            if result == 0 {
                return node
            } else if result < 0 {
                node = node!.right
            } else {
                node = node!.left
            }
        }
        return nil
    }
    
    /// 比较两个元素的大小
    /// - Returns:
    /// 如果element1 > element2,则返回正数
    /// 如果element1 < element2,则返回负数
    /// 如果element1 = element2,则返回0
    private func compare(element1: E, element2: E) -> Int {
        if self.comparator != nil {
            return self.comparator!(element1, element2)
        }
        if element1 < element2 {
            return -1
        } else if element1 > element2 {
            return 1
        }
        return 0
    }
}

//
//  BinaryTree.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/28.
//

import Foundation
class BinaryTreeNode<E>: CustomStringConvertible {
    var element: E
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var parent: BinaryTreeNode?
    init(element: E, left: BinaryTreeNode? = nil, right: BinaryTreeNode? = nil, parent: BinaryTreeNode? = nil) {
        self.element = element
        self.left = left
        self.right = right
        self.parent = parent
    }
    
    func isLeftChild() -> Bool {
        if parent == nil {
            return false
        }
        return parent!.left === self
    }
    
    func isRightChild() -> Bool {
        if parent == nil {
            return false
        }
        return parent!.right === self
    }
    
    deinit {
        print("BinaryTreeNode - \(element) - deinit")
    }
    
    var description: String {
        return "\(self.element)"
    }
}

class BinaryTree<E: Comparable>: NSObject, MJBinaryTreeInfo {
    var _size: Int = 0
    var rootNode: BinaryTreeNode<E>?
    var comparator: ((_ element1: E, _ element2: E) -> Int)?
    
    init(comparator: @escaping (_: any Comparable, _: any Comparable) -> Int) {
        self.comparator = comparator
    }
    
    override init() {
        super.init()
    }
    
    func size() -> Int {
        return _size
    }
    
    func add(element: E) {
        if self.checkIsNull(element: element) {
            return
        }
        let addNode = BinaryTreeNode(element: element)
        add(element: addNode)
    }
    
    func add(element: BinaryTreeNode<E>) {
        
    }
    
    func remove(element: E) -> E? {
        return nil
    }
    
    func contains(element: E) -> Bool {
        return node(element: element) != nil
    }
    
    func checkIsNull(element: E?) -> Bool {
        if element == nil {
            return true
        }
        return false
    }
    
    func node(element: E) -> BinaryTreeNode<E>? {
        return nil
    }
    
    /// 是否是叶子节点
    static func isLeaf(node: BinaryTreeNode<E>?) -> Bool {
        if node == nil {
            return false
        }
        return node!.left == nil && node!.right == nil
    }
    
    /// 是否是度为1的节点
    static func hasOnlyOneChild(node: BinaryTreeNode<E>?) -> Bool {
        if node == nil {
            return false
        }
        var childCount = 0
        if node!.left != nil {
            childCount += 1
        }
        if node!.right != nil {
            childCount += 1
        }
        return childCount == 1
    }
    
    /// 是否是度为2的节点
    static func hasTwoChild(node: BinaryTreeNode<E>?) -> Bool {
        if node == nil {
            return false
        }
        return node!.left != nil && node!.right != nil
    }
    
    // MARK: - Iterator
    func preorder(visitor: ((_ element: E) -> Void)?) {
        // 前序遍历
        preorder(node: rootNode, visitor: visitor)
    }

    private func preorder(node: BinaryTreeNode<E>?, visitor: ((_ element: E) -> Void)?) {
        if node == nil {
            return
        }
        if visitor != nil {
            visitor!(node!.element)
        }
        preorder(node: node!.left, visitor: visitor)
        preorder(node: node!.right, visitor: visitor)
    }
    
    func inorder(visitor: ((_ element: E) -> Void)?) {
        // 中序遍历
        inorder(node: rootNode, visitor: visitor)
    }
    
    private func inorder(node: BinaryTreeNode<E>?, visitor: ((_ element: E) -> Void)?) {
        if node == nil {
            return
        }
        inorder(node: node!.left, visitor: visitor)
        if visitor != nil {
            visitor!(node!.element)
        }
        inorder(node: node!.right, visitor: visitor)
    }
    
    func postorder(visitor: ((_ element: E) -> Void)?) {
        // 后序遍历
        postorder(node: rootNode, visitor: visitor)
    }
    
    private func postorder(node: BinaryTreeNode<E>?, visitor: ((_ element: E) -> Void)?) {
        if node == nil {
            return
        }
        postorder(node: node!.left, visitor: visitor)
        postorder(node: node!.right, visitor: visitor)
        if visitor != nil {
            visitor!(node!.element)
        }
    }
    
    func levelOrder(visitor: ((_ element: E) -> Void)?) {
        // 层序遍历
        if rootNode == nil {
            return
        }
        var queue = [BinaryTreeNode<E>]()
        queue.append(rootNode!)
        levelOrder(queue: queue, visitor: visitor)
    }
    func levelOrder(queue: Array<BinaryTreeNode<E>>, visitor: ((_ element: E) -> Void)?) {
        if queue.count == 0 {
            return
        }
        var tempQueue = queue
        let node = tempQueue.first
        if node!.left != nil {
            tempQueue.append(node!.left!)
        }
        if node!.right != nil {
            tempQueue.append(node!.right!)
        }
        if visitor != nil {
            visitor!(node!.element)
        }
        tempQueue.removeFirst()
        levelOrder(queue: tempQueue, visitor: visitor)
    }
    /// 前驱节点
    func precursor(node: BinaryTreeNode<E>?) -> BinaryTreeNode<E>? {
        if node == nil {
            return nil
        }
        // 当前节点有左子树
        // 当前节点的左子树中最右下角的节点
        if node!.left != nil {
            var precursorNode = node!.left!
            while precursorNode.right != nil {
                precursorNode = precursorNode.right!
            }
            return precursorNode
        }
        // 当前节点没有左子树
        // 找当前节点的parent,直到当前节点是parent的右子树
        // 当parent == nil时还不满足条件,则没有前驱节点
        var precursorNode = node!.parent
        var currentNode = node!
        while precursorNode != nil {
            if precursorNode!.right?.element == currentNode.element {
                return precursorNode
            }
            currentNode = precursorNode!
            precursorNode = precursorNode!.parent
        }
        return nil
    }
    /// 前驱节点
    func precursor(element: E) -> E? {
        let node = node(element: element)
        if node == nil {
            return nil
        }
        return precursor(node: node)?.element
    }
    
    /// 后继节点(只需要将前驱结点的代码left和right互换即可)
    func successor(node: BinaryTreeNode<E>?) -> BinaryTreeNode<E>? {
        if node == nil {
            return nil
        }
        // 当前节点有右子树
        // 当前节点的右子树中最左下角的节点
        if node!.right != nil {
            var successorNode = node!.right!
            while successorNode.left != nil {
                successorNode = successorNode.left!
            }
            return successorNode
        }
        // 当前节点没有右子树
        // 找当前节点的parent,直到当前节点是parent的左子树
        // 当parent == nil时还不满足条件,则没有前驱节点
        var successorNode = node!.parent
        var currentNode = node!
        while successorNode != nil {
            if successorNode!.left?.element == currentNode.element {
                return successorNode
            }
            currentNode = successorNode!
            successorNode = successorNode!.parent
        }
        return nil
    }
    
    /// 后继节点(只需要将前驱结点的代码left和right互换即可)
    func successor(element: E) -> E? {
        let node = node(element: element)
        if node == nil {
            return nil
        }
        return successor(node: node)?.element
    }
    // MARK: - MJBinaryTreeInfo
    func root() -> Any {
        return rootNode as Any
    }
    
    func left(_ node: Any) -> Any {
        let tempNode = node as? BinaryTreeNode<E>
        return tempNode?.left as Any
    }
    
    func right(_ node: Any) -> Any {
        let tempNode = node as? BinaryTreeNode<E>
        return tempNode?.right as Any
    }
    
    func string(_ node: Any) -> Any {
        let tempNode = node as? BinaryTreeNode<E>
        return tempNode?.description as Any
    }
}

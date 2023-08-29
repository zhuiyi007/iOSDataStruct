//
//  TreeRun.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/8/11.
//

import Foundation

func treeRun() {
    let comparator = {(val1: any Comparable, val2: any Comparable) -> Int in
        let int1 = val1 as! Int
        let int2 = val2 as! Int
        return int1 - int2
    }

    var tree = BinarySearchTree<Int>(comparator: comparator)
    tree.add(element: 7);
    tree.add(element: 4);
    tree.add(element: 9);
    tree.add(element: 2);
    tree.add(element: 5);
    tree.add(element: 8);
    tree.add(element: 11);
    tree.add(element: 1);
    tree.add(element: 3);
    tree.add(element: 12);

    MJBinaryTrees.println(tree)
    print("--------")
    // 遍历
    tree.preorder(visitor: {(element: Int) -> Void in
        print(element)
    })
    print("--------")
    tree.inorder(visitor: {(element: Int) -> Void in
        print(element)
    })
    print("--------")
    tree.postorder(visitor: {(element: Int) -> Void in
        print(element)
    })
    print("--------")
    tree.levelOrder(visitor: {(element: Int) -> Void in
        print(element)
    })
    print("--------")
    // 树的高度
    print(TreeExercise().treeHeight(root: tree.rootNode))
    // 是否为完全二叉树
    print(TreeExercise().fullBinaryTree(root: tree.rootNode))
    // 反转二叉树
    TreeExercise().reverseBinaryTree(root: tree.rootNode)
    print(MJBinaryTrees.println(tree))

    print("--------")
    tree = BinarySearchTree<Int>(comparator: comparator)
    tree.add(element: 1);
    tree.add(element: 2);
    tree.add(element: 3);
    tree.add(element: 4);
    tree.add(element: 5);
    tree.add(element: 6);
    tree.add(element: 7);
    tree.add(element: 8);
    tree.add(element: 9);
    tree.add(element: 10);
    MJBinaryTrees.println(tree)
    print("--------")
    // 树的高度
    print(TreeExercise().treeHeight(root: tree.rootNode))
    // 反转二叉树
    TreeExercise().reverseBinaryTree(root: tree.rootNode)
    print(MJBinaryTrees.println(tree))
    print("--------")
    // 前驱节点
    tree = BinarySearchTree<Int>(comparator: comparator)
    tree.add(element: 8);
    tree.add(element: 4);
    tree.add(element: 13);
    tree.add(element: 2);
    tree.add(element: 6);
    tree.add(element: 10);
    tree.add(element: 1);
    tree.add(element: 3);
    tree.add(element: 5);
    tree.add(element: 7);
    tree.add(element: 9);
    tree.add(element: 12);
    tree.add(element: 11);
    MJBinaryTrees.println(tree)
    print("--------")
    print("node: 1 precursor is \(String(describing: tree.precursor(element: 1)))")
    print("node: 8 precursor is \(String(describing: tree.precursor(element: 8)))")
    print("node: 11 precursor is \(String(describing: tree.precursor(element: 11)))")
    
    print("--------")
    // 后继节点
    tree = BinarySearchTree<Int>(comparator: comparator)
    tree.add(element: 4);
    tree.add(element: 1);
    tree.add(element: 8);
    tree.add(element: 2);
    tree.add(element: 7);
    tree.add(element: 10);
    tree.add(element: 3);
    tree.add(element: 5);
    tree.add(element: 9);
    tree.add(element: 11);
    tree.add(element: 6);
    MJBinaryTrees.println(tree)
    print("--------")
    print("node: 1 successor is \(String(describing: tree.successor(element: 1)))")
    print("node: 8 successor is \(String(describing: tree.successor(element: 8)))")
    print("node: 7 successor is \(String(describing: tree.successor(element: 7)))")
    print("node: 6 successor is \(String(describing: tree.successor(element: 6)))")
    print("--------")
    // 删除节点
    tree = BinarySearchTree<Int>(comparator: comparator)
    tree.add(element: 7);
    tree.add(element: 4);
    tree.add(element: 9);
    tree.add(element: 2);
    tree.add(element: 5);
    tree.add(element: 8);
    tree.add(element: 11);
    tree.add(element: 3);
    tree.add(element: 10);
    MJBinaryTrees.println(tree)
    // 删除一个叶子节点
    print("remove node:\(tree.remove(element: 3) ?? -1)")
    MJBinaryTrees.println(tree)
    // 删除一个度为1的节点
    print("remove node:\(tree.remove(element: 11) ?? -1)")
    MJBinaryTrees.println(tree)
    // 删除一个度为2的节点
    print("remove node:\(tree.remove(element: 9) ?? -1)")
    MJBinaryTrees.println(tree)
    // 构造一个度为1的根节点
    print("remove node:\(tree.remove(element: 8) ?? -1)")
    print("remove node:\(tree.remove(element: 10) ?? -1)")
    /// 删除一个度为1的根节点
    print("remove node:\(tree.remove(element: 7) ?? -1)")
    MJBinaryTrees.println(tree)
    /// 构造一个叶子节点的根节点
    print("remove node:\(tree.remove(element: 2) ?? -1)")
    print("remove node:\(tree.remove(element: 5) ?? -1)")
    /// 删除唯一的根节点
    print("remove node:\(tree.remove(element: 4) ?? -1)")
    MJBinaryTrees.println(tree)
    print("--------")
    
    let array = [15, 67, 9, 12, 49, 60, 97, 41, 87, 71, 99, 14, 1, 74, 84]
    tree = AVLTree(comparator: comparator)
    for i in array {
        print("***************************")
        print("add : \(i)")
        tree.add(element: i)
        MJBinaryTrees.println(tree)
    }
    print("--------")
    for i in array {
        print("***************************")
        print("remove : \(i)")
        tree.remove(element: i)
        MJBinaryTrees.println(tree)
    }
    print("--------")
}

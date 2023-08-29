//
//  BinaryTreeTests.swift
//  dataStructTests_2023
//
//  Created by firstzhang on 2023/8/15.
//

import XCTest

final class BinaryTreeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNodeChild() throws {
        let node = BinaryTreeNode(element: 1)
        XCTAssertTrue(BinaryTree.isLeaf(node: node))
        XCTAssertFalse(BinaryTree.hasOnlyOneChild(node: node))
        XCTAssertFalse(BinaryTree.hasTwoChild(node: node))
        node.left = BinaryTreeNode(element: 2)
        XCTAssertFalse(BinaryTree.isLeaf(node: node))
        XCTAssertTrue(BinaryTree.hasOnlyOneChild(node: node))
        XCTAssertFalse(BinaryTree.hasTwoChild(node: node))
        node.right = BinaryTreeNode(element: 3)
        XCTAssertFalse(BinaryTree.isLeaf(node: node))
        XCTAssertFalse(BinaryTree.hasOnlyOneChild(node: node))
        XCTAssertTrue(BinaryTree.hasTwoChild(node: node))
    }
    
    func testIterator() throws {
        let node = BinaryTreeNode(element: 1)
        node.left = BinaryTreeNode(element: 2)
        node.right = BinaryTreeNode(element: 3)
        let tree = BinaryTree<Int>()
        tree.rootNode = node
        
        var iteratorArray = [1, 2, 3]
        var index = 0
        tree.preorder(visitor: {(element: Int) -> Void in
            XCTAssertEqual(element, iteratorArray[index])
            index += 1
        })
        
        index = 0
        iteratorArray = [2, 1, 3]
        tree.inorder(visitor: {(element: Int) -> Void in
            XCTAssertEqual(element, iteratorArray[index])
            index += 1
        })
        
        index = 0
        iteratorArray = [2, 3, 1]
        tree.postorder(visitor: {(element: Int) -> Void in
            XCTAssertEqual(element, iteratorArray[index])
            index += 1
        })
        
        index = 0
        iteratorArray = [1, 2, 3]
        tree.levelOrder(visitor: {(element: Int) -> Void in
            XCTAssertEqual(element, iteratorArray[index])
            index += 1
        })
    }
    
    func testPrecursorAndSuccessor() throws {
        var tree = BinarySearchTree<Int>()
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
        XCTAssertEqual(tree.size(), 13)
        XCTAssertNil(tree.precursor(element: 1))
        XCTAssertEqual(tree.precursor(element: 8), 7)
        XCTAssertEqual(tree.precursor(element: 11), 10)
        
        // 后继节点
        tree = BinarySearchTree<Int>()
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
        XCTAssertEqual(tree.size(), 11)
        XCTAssertEqual(tree.successor(element: 1), 2)
        XCTAssertEqual(tree.successor(element: 8), 9)
        XCTAssertEqual(tree.successor(element: 7), 8)
        XCTAssertEqual(tree.successor(element: 6), 7)
    }
    
    func testRemove() throws {
        // 删除节点
        let tree = BinarySearchTree<Int>()
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
        XCTAssertEqual(tree.size(), 9)
        // 删除一个叶子节点
        XCTAssertEqual(tree.remove(element: 5), 5)
        XCTAssertEqual(tree.size(), 8)
        // 删除一个度为1的节点
        // 父节点的右子树
        XCTAssertEqual(tree.remove(element: 11), 11)
        // 父节点的左子树
        XCTAssertEqual(tree.remove(element: 2), 2)
        XCTAssertEqual(tree.size(), 6)
        // 删除一个度为2的节点
        XCTAssertEqual(tree.remove(element: 9), 9)
        XCTAssertEqual(tree.size(), 5)
        // 构造一个度为1的根节点
        XCTAssertEqual(tree.remove(element: 8), 8)
        XCTAssertEqual(tree.remove(element: 10), 10)
        /// 删除一个度为1的根节点
        XCTAssertEqual(tree.remove(element: 7), 7)
        XCTAssertEqual(tree.size(), 2)
        /// 构造一个叶子节点的根节点
        XCTAssertEqual(tree.remove(element: 3), 3)
        /// 删除唯一的根节点
        XCTAssertEqual(tree.remove(element: 4), 4)
        XCTAssertEqual(tree.size(), 0)
    }
    
    func testContains() throws {
        let node = BinaryTreeNode(element: 1)
        node.left = BinaryTreeNode(element: 2)
        node.right = BinaryTreeNode(element: 3)
        let tree = BinarySearchTree<Int>()
        tree.rootNode = node
        
        XCTAssertTrue(tree.contains(element: 1))
        XCTAssertFalse(tree.contains(element: 4))
    }

}

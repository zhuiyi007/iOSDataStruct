//
//  BalanceBinarySearchTree.m
//  dataStruct
//
//  Created by 张森 on 2021/5/11.
//

#import "BalanceBinarySearchTree.h"

@implementation BalanceBinarySearchTree

/// 向左旋转节点
/// @param node node
- (void)_rotateNodeLeft:(BinaryTreeNode *)node {
    
    BinaryTreeNode *grand = node;
    BinaryTreeNode *parent = grand.right;
    BinaryTreeNode *child = parent.left;
    
    // 旋转
    grand.right = child;
    parent.left = grand;
    
    // 维护parent
    [self _afterRotate:grand parent:parent child:child];
}

/// 向右旋转节点
/// @param node node
- (void)_rotateNodeRight:(BinaryTreeNode *)node {
    
    BinaryTreeNode *grand = node;
    BinaryTreeNode *parent = grand.left;
    BinaryTreeNode *child = parent.right;
    
    // 旋转
    parent.right = grand;
    grand.left = child;
    
    // 维护parent
    [self _afterRotate:grand parent:parent child:child];
}

- (void)_afterRotate:(BinaryTreeNode *)grand parent:(BinaryTreeNode *)parent child:(BinaryTreeNode *)child {
    
    // 维护parent
    parent.parent = grand.parent;
    if ([grand isLeftChild]) {
        // node节点是其父节点left
        grand.parent.left = parent;
    } else if ([grand isRightChild]) {
        // node节点是其父节点right
        grand.parent.right = parent;
    } else {
        // 根节点
        self.rootNode = parent;
    }
    
    child.parent = grand;
    grand.parent = parent;
}

@end

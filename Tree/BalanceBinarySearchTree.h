//
//  BalanceBinarySearchTree.h
//  dataStruct
//
//  Created by 张森 on 2021/5/11.
//

#import "BinarySearchTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalanceBinarySearchTree : BinarySearchTree

/// 向左旋转节点
/// @param node node
- (void)_rotateNodeLeft:(BinaryTreeNode *)node;

/// 向右旋转节点
/// @param node node
- (void)_rotateNodeRight:(BinaryTreeNode *)node;

/// 旋转完成后的操作
/// @param grand 祖父节点
/// @param parent 父节点
/// @param child 孩子节点
- (void)_afterRotate:(BinaryTreeNode *)grand parent:(BinaryTreeNode *)parent child:(BinaryTreeNode *)child;

@end

NS_ASSUME_NONNULL_END

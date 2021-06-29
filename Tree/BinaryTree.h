//
//  BinaryTree.h
//  dataStruct
//
//  Created by 张森 on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import "Compare.h"
#import "TreeCompartor.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeNode : NSObject

@property (nonatomic, strong) id<Compare> element;
@property (nonatomic, strong, nullable) BinaryTreeNode *left;
@property (nonatomic, strong, nullable) BinaryTreeNode *right;
@property (nonatomic, strong, nullable) BinaryTreeNode *parent;

/// 创建节点
/// @param node node
+ (instancetype)treeNode:(id<Compare>)node;
/// 判断当前节点是否为叶子节点
- (BOOL)isLeaf;
/// 判断当前节点是否度为2
- (BOOL)hasTwoChild;
/// 是否是父节点的左子树
- (BOOL)isLeftChild;
/// 是否是父节点的右子树
- (BOOL)isRightChild;
/// 返回兄弟节点
- (instancetype)brotherNode;
@end

@interface BinaryTree : NSObject

@property (nonatomic, strong, nullable) BinaryTreeNode *rootNode;
@property (nonatomic, assign) NSInteger size;
// 选择器,如果实现了选择器,默认先使用选择器
@property (nonatomic, strong, nullable) TreeCompartor *compartor;

#pragma mark - 基本操作

/// 初始化tree
/// @param compartor 比较器
+ (instancetype)treeWithCompartor:(nullable TreeCompartor *)compartor;

/// 返回树的大小
- (NSInteger)size;

/// 计算树的高度
- (NSInteger)height;

/// 是否是完全二叉树
- (BOOL)isCompleteTree;

/// 树是否为空
- (BOOL)isEmpty;

/// 清空树
- (void)clear;

#pragma mark - 遍历相关
/// 前序打印
- (void)preorderPrint:(void(^)(id node, BOOL *isStop))element;

/// 中序打印
/// 搜索二叉树的中序打印为升序或降序
- (void)inorderPrint:(void(^)(id node, BOOL *isStop))element;

/// 后序打印
- (void)postorderPrint:(void(^)(id node, BOOL *isStop))element;

/// 层序打印
- (void)levelorderPrint:(void(^)(id node, BOOL *isStop))element;


/// 比较器
/// @param element1 element1
/// @param element2 element2
- (NSInteger)_compare:(id<Compare>)element1 to:(id<Compare>)element2;

#pragma mark - 前驱后继

- (BinaryTreeNode *)_predecessor:(BinaryTreeNode *)node;

- (BinaryTreeNode *)_successor:(BinaryTreeNode *)node;

@end

NS_ASSUME_NONNULL_END

//
//  BinaryTree.m
//  dataStruct
//
//  Created by 张森 on 2021/4/21.
//

#import "BinaryTree.h"
#import "Queue.h"
#import "MJBinaryTreeInfo.h"

@implementation BinaryTreeNode
+ (instancetype)treeNode:(id<Compare>)node {
    
    BinaryTreeNode *treeNode = [[self alloc] init];
    treeNode.element = node;
    return treeNode;
}

- (BOOL)isLeaf {
    
    return !self.left && !self.right;
}

- (BOOL)hasTwoChild {
    
    return self.left && self.right;
}

/// 是否是父节点的左子树
- (BOOL)isLeftChild {
    
    return self.parent.left == self;
}
/// 是否是父节点的右子树
- (BOOL)isRightChild {
    
    return self.parent.right == self;
}

/// 返回兄弟节点
- (instancetype)brotherNode {
    
    if ([self isLeftChild]) {
        return self.parent.right;
    } else if ([self isRightChild]) {
        return self.parent.left;
    } else {
        return nil;
    }
}

@end
@interface BinaryTree ()<MJBinaryTreeInfo>

@end
@implementation BinaryTree

#pragma mark - 基本操作
+ (instancetype)treeWithCompartor:(nullable TreeCompartor *)compartor {
    
    BinaryTree *tree = [[self alloc] init];
    tree.compartor = compartor;
    return tree;
}

- (NSInteger)size {
    
    return _size;
}

/// 计算树的高度
- (NSInteger)height {
    
    Queue *queue = [Queue queue];
    [queue push:self.rootNode];
    NSInteger height = 0;
    // 每一层的数量
    NSInteger levelSize = 1;
    while ([queue size] > 0) {
        
        BinaryTreeNode *node = [queue front];
        if (node.left) {
            
            [queue push:node.left];
        }
        
        if (node.right) {
            
            [queue push:node.right];
        }
        [queue pop];
        // 每遍历完一个元素,当前层的元素数量就减一
        levelSize --;
        if (levelSize == 0) {
            // 当前层遍历完后,队列的数量就是下一层元素的数量
            levelSize = [queue size];
            // 遍历完一层,高度加一
            height ++;
        }
    }
    return height;
    // 递归方法
//    return [self _height:self.rootNode];
}

//- (NSInteger)_height:(BinaryTreeNode *)node {
//
//    if (!node) {
//        return 0;
//    }
//    return 1 + MAX([self _height:node.left], [self _height:node.right]);
//}

/// 是否是完全二叉树
- (BOOL)isCompleteTree {
    
    if (!self.rootNode) {
        return NO;
    }
    
    // 1. 采用层序遍历的方式来进行判断
    // 2. 如果一个节点只有左子树,没有右子树;或两边都没有时,证明从这个节点之后的节点都是叶子节点
    //      - 在后面的节点中,应该都是叶子节点,即左右子树都不存在,否则,返回NO
    // 3. 如果有右子树,没有左子树,直接返回NO
    Queue *queue = [Queue queue];
    [queue push:self.rootNode];
    
    BOOL leaf = NO;
    while ([queue size] > 0) {
        
        BinaryTreeNode *node = [queue front];
        [queue pop];
        
        if (leaf && ![node isLeaf]) {
            // 如果是叶子节点,且有左右子树,直接返回NO
            return NO;
        }
        
        if (node.left) {
            // 有左边,则入队
            [queue push:node.left];
        } else if (node.right) {
            // !node.left
            // 没有左边,且有右边,则直接返回NO
            return NO;
        }
        
        if (node.right) {
            // 有右边,则入队
            [queue push:node.right];
        } else {
            // 没有右节点,则证明是叶子节点
            leaf = YES;
        }
    }
    return YES;
}

- (BOOL)isEmpty {
    
    if (self.rootNode) {
        
        return YES;
    }
    return NO;
}

- (void)clear {
    
    self.rootNode = nil;
    self.size = 0;
}

#pragma mark - 遍历相关

static BOOL _preorderStop = NO;
/// 前序打印
- (void)preorderPrint:(void(^)(id node, BOOL *isStop))element {
    
    if (!element) {
        return;
    }
    _preorderStop = NO;
    [self _preorderPrint:self.rootNode element:element];
}

static BOOL _inorderStop = NO;
/// 中序打印
- (void)inorderPrint:(void(^)(id node, BOOL *isStop))element {
    
    if (!element) {
        return;
    }
    _inorderStop = NO;
    [self _inorderPrint:self.rootNode element:element];
}

static BOOL _postorderStop = NO;
/// 后序打印
- (void)postorderPrint:(void(^)(id node, BOOL *isStop))element {
    
    if (!element) {
        return;
    }
    _postorderStop = NO;
    [self _postorderPrint:self.rootNode element:element];
}

static BOOL _levelorderStop = NO;
/// 层序打印
- (void)levelorderPrint:(void(^)(id node, BOOL *isStop))element {
    
    _levelorderStop = NO;
    if (!self.rootNode || !element) {
        return;
    }
    Queue *queue = [Queue queue];
    [queue push:self.rootNode];
    while ([queue size] > 0) {
        
        BinaryTreeNode *node = [queue front];
        if (_levelorderStop) {
            _levelorderStop = NO;
            return;
        }
        element(node.element, &_levelorderStop);
        
        if (node.left) {
            
            [queue push:node.left];
        }
        
        if (node.right) {
            
            [queue push:node.right];
        }
        [queue pop];
    }
}

/// 私有方法前序打印
/// @param rootNode 根节点
/// @param element 遍历block
- (void)_preorderPrint:(BinaryTreeNode *)rootNode element:(void(^)(id node, BOOL *isStop))element {
    
    if (!rootNode || _preorderStop) {
        return;
    }
    
    if (!_preorderStop) {
        
        element(rootNode.element, &_preorderStop);
    }
    [self _preorderPrint:rootNode.left element:element];
    [self _preorderPrint:rootNode.right element:element];
}

/// 私有方法中序打印
/// @param rootNode 根节点
/// @param element 遍历block
- (void)_inorderPrint:(BinaryTreeNode *)rootNode element:(void(^)(id node, BOOL *isStop))element {
    
    if (!rootNode || _inorderStop) {
        return;
    }
    [self _inorderPrint:rootNode.left element:element];
    if (!_inorderStop) {
        
        element(rootNode.element, &_inorderStop);
    }
    [self _inorderPrint:rootNode.right element:element];
}

/// 私有方法后序打印
/// @param rootNode 根节点
/// @param element 遍历block
- (void)_postorderPrint:(BinaryTreeNode *)rootNode element:(void(^)(id node, BOOL *isStop))element {
    
    if (!rootNode || _postorderStop) {
        return;
    }
    [self _postorderPrint:rootNode.left element:element];
    [self _postorderPrint:rootNode.right element:element];
    if (!_postorderStop) {
        
        element(rootNode.element, &_postorderStop);
    }
}

- (NSInteger)_compare:(id<Compare>)element1 to:(id<Compare>)element2 {
    
    if (self.compartor) {
        return [self.compartor compare:element1 to:element2];
    }
    return [element1 compareTo:element2];
}

#pragma mark - 前驱后继

- (BinaryTreeNode *)_predecessor:(BinaryTreeNode *)node {
    // 前驱 -> 中序遍历中当前节点的前一个节点
    // 利用二叉搜索树来理解,即为找到比当前节点小的最大的数
    // 1. 如果有左子树,则从左子树中寻找最右下角的节点
    // 2. 如果没有左子树,则一直找parent,直到parent的右节点等于当前节点
    if (!node) {
        return nil;
    }
    if (node.left) {
        // 左子树不为空,则从左子树中一直往右找
        BinaryTreeNode *tempNode = node.left;
        while (tempNode.right) {
            tempNode = tempNode.right;
        }
        return tempNode;
    } else {
        // 左子树为空,需要往上找parent
        while (node.parent && node.parent.left == node) {
            node = node.parent;
        }
        // 退出循环
        // 1. node没有parent了,则证明没有前驱节点
        // 2. node为node.parent的右节点,则前驱为node.parent
        return node.parent;
    }
}

- (BinaryTreeNode *)_successor:(BinaryTreeNode *)node {
    // 后继 -> 中序遍历中当前节点的后一个节点
    // 利用二叉搜索树来理解,即为找到比当前节点大的最小的数
    // 1. 如果有右子树,则从右子树中寻找最左下角的节点
    // 2. 如果没有右子树,则一直找parent,直到parent的左节点等于当前节点
    if (!node) {
        return nil;
    }
    if (node.right) {
        // 右子树不为空,则从右子树中一直往左找
        BinaryTreeNode *tempNode = node.right;
        while (tempNode.left) {
            tempNode = tempNode.left;
        }
        return tempNode;
    } else {
        // 右子树为空,需要往上找parent
        while (node.parent && node.parent.right == node) {
            node = node.parent;
        }
        // 退出循环
        // 1. node没有parent了,则证明没有前驱节点
        // 2. node为node.parent的左节点,则前驱为node.parent
        return node.parent;
    }
}

#pragma mark - protpcol
- (id)root {
    return self.rootNode;
}

- (id)left:(BinaryTreeNode *)node {
    
    return node.left;
}

- (id)right:(BinaryTreeNode *)node {
    
    return node.right;
}

- (id)string:(BinaryTreeNode *)node {
    
    return [NSString stringWithFormat:@"%@(p-%@)", node.element, node.parent.element];
}

@end

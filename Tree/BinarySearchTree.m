//
//  BinarySearchTree.m
//  dataStruct
//
//  Created by 张森 on 2021/4/15.
//

#import "BinarySearchTree.h"
#import "TreeCompartor.h"
#import "Queue.h"

@implementation BinarySearchTree

- (void)add:(id<Compare>)element {
    
    if (!element) {
        return;
    }
    BinaryTreeNode *node = [self _createNode:element];
    if (!self.rootNode) {
        self.rootNode = node;
        self.size ++;
        
        [self _afterAdd:node];
        return;
    }
    BinaryTreeNode *parent = self.rootNode;
    BinaryTreeNode *tmpNode = self.rootNode;
    NSInteger compareResult = 0;
    while (tmpNode) {
        
        parent = tmpNode;
        compareResult = [self _compare:tmpNode.element to:node.element];
        if (compareResult > 0) {
            // 根节点比要插入的节点大
            // 需要往左继续查找
            tmpNode = tmpNode.left;
        } else if (compareResult < 0) {
            // 根节点比要插入的节点小
            // 需要往右继续查找
            tmpNode = tmpNode.right;
        } else {
            // 节点相同, 覆盖
            tmpNode = node;
            return;
        }
    }
    
    if (compareResult > 0) {
        parent.left = node;
    } else {
        parent.right = node;
    }
    node.parent = parent;
    
    [self _afterAdd:node];
    self.size ++;
}

- (void)remove:(id<Compare>)element {
    
    if (!element) {
        return;
    }
    BinaryTreeNode *node = [self _findNode:element];
    if (!node) {
        return;
    }
    
    self.size --;
    // 度为2的节点
    BinaryTreeNode *replaceNode = nil;
    if ([node hasTwoChild]) {
        // 寻找其前驱或后继
        replaceNode = [self _successor:node];
        // 进行值覆盖
        node.element = replaceNode.element;
        node = replaceNode;
    }

    // 走到这个地方,node肯定是度为0或1的节点
    // 删除node
    BinaryTreeNode *childNode = node.left ? : node.right;
    if ([node isLeaf]) {
        // 叶子节点
        if ([node isLeftChild]) {
            node.parent.left = nil;
        } else if ([node isRightChild]){
            node.parent.right = nil;
        } else {
            // 既是叶子节点,也是根节点
            self.rootNode = nil;
        }
    } else {
        // 度为1的节点
        if ([node isLeftChild]) {
            node.parent.left = childNode;
        } else {
            node.parent.right = childNode;
        }
        childNode.parent = node.parent;
        if (!childNode.parent) {
            self.rootNode = childNode;
        }
        replaceNode = childNode;
    }
    
    [self _afterRemove:node replace:replaceNode];
}

- (BOOL)contains:(id<Compare>)element {
    
    return [self _findNode:element] != nil;
}


/// 根据节点内容返回节点
/// @param element element
- (BinaryTreeNode *)_findNode:(id<Compare>)element {
    
    if (!element) {
        
        return nil;
    }
    BinaryTreeNode *node = self.rootNode;
    
    while (node) {
        if ([self _compare:node.element to:element] < 0) {
            // 当前节点比element小
            // 需要去right中找
            node = node.right;
        } else if ([self _compare:node.element to:element] > 0) {
            // 当前节点比element大
            // 需要去left中找
            node = node.left;
        } else {
            // 两者相等
            return node;
        }
    };
    
    return nil;
}

- (BinaryTreeNode *)_createNode:(id<Compare>)element {
    
    return [BinaryTreeNode treeNode:element];
}

- (void)_afterAdd:(BinaryTreeNode *)node {
    
}

- (void)_afterRemove:(BinaryTreeNode *)node replace:(BinaryTreeNode *)replaceNode{
    
}
@end

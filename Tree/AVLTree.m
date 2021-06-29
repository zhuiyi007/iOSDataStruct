//
//  AVLTree.m
//  dataStruct
//
//  Created by 张森 on 2021/4/21.
//

#import "AVLTree.h"

@interface AVLTreeNode : BinaryTreeNode

@property (nonatomic, assign) NSInteger height;

@end

@implementation AVLTreeNode

+ (instancetype)treeNode:(id<Compare>)node {
    
    AVLTreeNode *avlTreeNode = [super treeNode:node];
    avlTreeNode.height = 1;
    return avlTreeNode;
}

- (NSInteger)balanceFactor {
    
    NSInteger leftHeight = self.left ? [(AVLTreeNode *)self.left height] : 0;
    NSInteger rightHeight = self.right ? [(AVLTreeNode *)self.right height] : 0;
    return leftHeight - rightHeight;
}

- (BOOL)isBalance {
    
    return labs([self balanceFactor]) <= 1;
}

- (void)updateHeight {
    
    NSInteger leftHeight = self.left ? [(AVLTreeNode *)self.left height] : 0;
    NSInteger rightHeight = self.right ? [(AVLTreeNode *)self.right height] : 0;
    self.height = MAX(leftHeight, rightHeight) + 1;
}

@end

@implementation AVLTree

- (void)_afterAdd:(AVLTreeNode *)node {
    
    while ((node = (AVLTreeNode *)node.parent) != nil) {
        
        if ([node isBalance]) {
            // 平衡,更新高度
            [node updateHeight];
        } else {
            // 不平衡,恢复平衡
            // 此处是高度最低的不平衡的节点
            // 对此节点恢复平衡后,整棵树恢复平衡
            [self _rebalance:node];
            break;
        }
    }
}

- (void)_afterRemove:(AVLTreeNode *)node replace:(AVLTreeNode *)replaceNode {
    
    while ((node = (AVLTreeNode *)node.parent) != nil) {

        if ([node isBalance]) {
            // 平衡,更新高度
            [node updateHeight];
        } else {
            // 不平衡,恢复平衡
            // 此处是高度最低的不平衡的节点
            // 删除节点平衡时,有可能所有父节点都失衡,需要一直往上平衡到根节点
            [self _rebalance:node];
        }
    }
}

- (void)_rebalance:(AVLTreeNode *)grand {
    
    if ([(AVLTreeNode *)grand.left height] > [(AVLTreeNode *)grand.right height]) { // L
        AVLTreeNode *parent = (AVLTreeNode *)grand.left;
        if ([(AVLTreeNode *)parent.left height] > [(AVLTreeNode *)parent.right height]) { // LL
            
            [self _rotateNodeRight:grand];
        } else { // LR
            
            [self _rotateNodeLeft:(AVLTreeNode *)grand.left];
            [self _rotateNodeRight:(AVLTreeNode *)grand];
        }
    } else { // R
        AVLTreeNode *parent = (AVLTreeNode *)grand.right;
        if ([(AVLTreeNode *)parent.left height] > [(AVLTreeNode *)parent.right height]) { // RL
            
            [self _rotateNodeRight:(AVLTreeNode *)grand.right];
            [self _rotateNodeLeft:(AVLTreeNode *)grand];
        } else { // RR
            
            [self _rotateNodeLeft:grand];
        }
    }
}

- (void)_afterRotate:(BinaryTreeNode *)grand parent:(BinaryTreeNode *)parent child:(BinaryTreeNode *)child {
    
    [super _afterRotate:grand parent:parent child:child];
    // 更新高度
    [(AVLTreeNode *)grand updateHeight];
    [(AVLTreeNode *)parent updateHeight];
}

- (AVLTreeNode *)_createNode:(id<Compare>)element {
    
    return [AVLTreeNode treeNode:element];
}

- (id)string:(AVLTreeNode *)node {
    
    return [NSString stringWithFormat:@"%@(p-%@ | h-%ld)", node.element, node.parent.element, (long)node.height];
}

@end

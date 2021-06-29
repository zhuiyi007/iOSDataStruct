//
//  RedBlackTree.m
//  dataStruct
//
//  Created by 张森 on 2021/4/23.
//

#import "RedBlackTree.h"

typedef BOOL RedBlackTreeNodeColor;
static RedBlackTreeNodeColor const RedBlackTreeNodeColorRed = YES;
static RedBlackTreeNodeColor const RedBlackTreeNodeColorBlack = NO;
@interface RedBlackTreeNode : BinaryTreeNode

@property (nonatomic, assign) RedBlackTreeNodeColor color;

@end

@implementation RedBlackTreeNode

+ (instancetype)treeNode:(id<Compare>)node {
    
    RedBlackTreeNode *redBlackTreeNode = [super treeNode:node];
    redBlackTreeNode.color = RedBlackTreeNodeColorRed;
    return redBlackTreeNode;
}

/// 染色
/// @param color color
- (RedBlackTreeNode *)_colorTo:(RedBlackTreeNodeColor)color {
    
    self.color = color;
    return self;
}

/// 染成红色
- (RedBlackTreeNode *)_colorRed {
    
    return [self _colorTo:RedBlackTreeNodeColorRed];
}

/// 染成黑色
- (RedBlackTreeNode *)_colorBlack {
    
    return [self _colorTo:RedBlackTreeNodeColorBlack];
}

/// 返回节点的颜色
- (RedBlackTreeNodeColor)_color {
    
    return self.color;
}

/// 是否为红色
+ (BOOL)_isRedColor:(RedBlackTreeNode *)node {
    
    return [node _color] == RedBlackTreeNodeColorRed;
}

/// 是否为黑色
+ (BOOL)_isBlackColor:(RedBlackTreeNode *)node {
    
    if (!node) {
        // 默认为黑色
        return YES;
    }
    return [node _color] == RedBlackTreeNodeColorBlack;
}
@end

@implementation RedBlackTree

- (RedBlackTreeNode *)_createNode:(id<Compare>)element {
    
    return [RedBlackTreeNode treeNode:element];
}

- (void)_afterAdd:(RedBlackTreeNode *)node {
    
    RedBlackTreeNode *parent = (RedBlackTreeNode *)node.parent;
    RedBlackTreeNode *grand = (RedBlackTreeNode *)node.parent.parent;
    
    if (!parent) {
        // 如果是根节点,则直接染成黑色
        // 或者是上溢到根节点
        [node _colorBlack];
        return;
    }
    if ([RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)parent]) {
        // 如果父节点是黑色,则不用做任何操作,直接返回
        return;
    }
    
    if ([RedBlackTreeNode _isRedColor:(RedBlackTreeNode *)parent.brotherNode]) {
        // 叔父节点是红色
        // 父节点和叔父节点染成黑色
        [parent _colorBlack];
        [parent.brotherNode _colorBlack];
        // 祖父节点染成红色,进行上溢,重新处理
        [self _afterAdd:[grand _colorRed]];
        return;
    }
    
    // 如果叔父节点是黑色 或者 叔父节点为空
    if ([parent isLeftChild]) { // L
        
        [grand _colorRed];
        if ([node isLeftChild]) { // LL
            
            // 父节点染成黑色,祖父节点染成红色
            // 祖父节点右旋
            [parent _colorBlack];
        } else { // LR
            
            // 自己染成黑色,祖父染成红色
            // 进行双旋
            [node _colorBlack];
            [self _rotateNodeLeft:parent];
        }
        [self _rotateNodeRight:grand];
    } else { // R
        
        [grand _colorRed];
        if ([node isLeftChild]) { // RL
            
            // 自己染成黑色,祖父染成红色
            // 进行双旋
            [node _colorBlack];
            [self _rotateNodeRight:parent];
        } else { // RR
            
            // 父节点染成黑色,祖父节点染成红色
            // 祖父节点左旋
            [parent _colorBlack];
        }
        [self _rotateNodeLeft:grand];
    }
}

- (void)_afterRemove:(RedBlackTreeNode *)node replace:(RedBlackTreeNode *)replaceNode {
    
    if ([RedBlackTreeNode _isRedColor:node]) {
        // 如果删除的是红色节点,则直接return
        // 红黑树只可能删除叶子节点,如果叶子节点为红色,则删除完成后,不影响红黑树的性质,不需要处理
        return;
    }
    
    if ([RedBlackTreeNode _isRedColor:replaceNode]) {
        // 如果删除的节点要替代的节点是红色
        // 则删除后此节点代替删除的节点,成为B树的根节点,染成黑色即可
        [replaceNode _colorBlack];
        return;
    }
    
    RedBlackTreeNode *parent = (RedBlackTreeNode *)node.parent;
    if (!parent) {
        // 删除根节点
        return;
    }
    
    // 删除的是黑色叶子节点
    // 先判断被删除的node是左还是右
    bool isLeft = parent.left == nil || [node isLeftChild];
    // 拿到兄弟节点
    // 由于节点已经删除,此时不能直接用parent的left和right去取值
    RedBlackTreeNode *brotherNode = (RedBlackTreeNode *)(isLeft ? parent.right : parent.left);
    if (isLeft) { // 被删除的节点在左边,兄弟节点在右边
        // 两种情况左右相反
        if ([RedBlackTreeNode _isRedColor:brotherNode]) { // 兄弟节点是红色
            // 转成兄弟节点是黑色的情况
            [brotherNode _colorBlack];
            [parent _colorRed];
            [self _rotateNodeLeft:parent];
            // 更换兄弟
            brotherNode = (RedBlackTreeNode *)parent.right;
        }
        // 兄弟节点是黑色的情况
        if ([RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)brotherNode.left] && [RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)brotherNode.right]) {
            
            // 兄弟节点没有一个红色节点,父节点需要向下跟兄弟节点合并
            bool isParentBlack = [RedBlackTreeNode _isBlackColor:parent];
            [parent _colorBlack];
            [brotherNode _colorRed];
            // 父节点是黑色节点,在向下合并后,需要继续向上递归节点进行下溢
            if (isParentBlack) {
                [self _afterRemove:parent replace:nil];
            }
        } else {
            
            // 兄弟节点至少有一个红色子节点
            // 向兄弟节点借节点
            
            if ([RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)brotherNode.right]) { // 兄弟节点的左边是黑色,此时是LR的情况,先对兄弟节点进行左旋转,后续统一处理
                [self _rotateNodeRight:brotherNode];
                brotherNode = (RedBlackTreeNode *)parent.right;
            }
            
            // 兄弟染成跟父节点相同的颜色
            [brotherNode _colorTo:[parent _color]];
            [(RedBlackTreeNode *)brotherNode.right _colorBlack];
            [parent _colorBlack];
            [self _rotateNodeLeft:parent];
        }
    } else { // 被删除的节点在右边,兄弟节点在左边
        
        if ([RedBlackTreeNode _isRedColor:brotherNode]) { // 兄弟节点是红色
            // 转成兄弟节点是黑色的情况
            [brotherNode _colorBlack];
            [parent _colorRed];
            [self _rotateNodeRight:parent];
            // 更换兄弟
            brotherNode = (RedBlackTreeNode *)parent.left;
        }
        // 兄弟节点是黑色的情况
        if ([RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)brotherNode.left] && [RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)brotherNode.right]) {
            
            // 兄弟节点没有一个红色节点,父节点需要向下跟兄弟节点合并
            bool isParentBlack = [RedBlackTreeNode _isBlackColor:parent];
            [parent _colorBlack];
            [brotherNode _colorRed];
            // 父节点是黑色节点,在向下合并后,需要继续向上递归节点进行下溢
            if (isParentBlack) {
                [self _afterRemove:parent replace:nil];
            }
        } else {
            
            // 兄弟节点至少有一个红色子节点
            // 向兄弟节点借节点
            
            if ([RedBlackTreeNode _isBlackColor:(RedBlackTreeNode *)brotherNode.left]) { // 兄弟节点的左边是黑色,此时是LR的情况,先对兄弟节点进行左旋转,后续统一处理
                [self _rotateNodeLeft:brotherNode];
                brotherNode = (RedBlackTreeNode *)parent.left;
            }
            
            // 兄弟染成跟父节点相同的颜色
            [brotherNode _colorTo:[parent _color]];
            [(RedBlackTreeNode *)brotherNode.left _colorBlack];
            [parent _colorBlack];
            [self _rotateNodeRight:parent];
        }
    }
}

- (id)string:(RedBlackTreeNode *)node {
    
    return [NSString stringWithFormat:@"%@(p-%@ %@)", node.element, node.parent.element, [RedBlackTreeNode _isBlackColor:node] ? @"B" : @"R"];
}

@end

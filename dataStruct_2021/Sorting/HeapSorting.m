//
//  HeapSorting.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "HeapSorting.h"

@interface HeapSorting ()

@property (nonatomic, assign) NSInteger heapSize;

@end

@implementation HeapSorting

- (void)sort {
    
    // 1.原地建堆
    // 自下而上的下滤
    // 复杂度O(n)
    // 从第一个非叶子节点开始下滤
    self.heapSize = [self.array count];
    for (NSInteger index = (self.heapSize >> 1) - 1; index >= 0; index --) {
        [self _siftDown:index];
    }
    
    while (self.heapSize > 1) {
        // 交换第一个和最后一个
        [self exchange:0 to:self.heapSize - 1];
        self.heapSize --;
        [self _siftDown:0];
    }
}

/// 下滤
/// @param index index
- (void)_siftDown:(NSInteger)index {
    
    // 下滤的位置必须是非叶子节点
    // 完全二叉树的非叶子节点个数是总节点个数的一半
    NSInteger half = self.heapSize >> 1;
    
    NSNumber *indexElement = self.array[index];
    while (index < half) {
        // 能到这里来,说明有叶子节点
        // 有两种情况,1.左右节点都存在;2.只有左节点
        NSNumber *leftElement = self.array[(index << 1) + 1];
        NSInteger rightIndex = (index << 1) + 2;
        NSInteger maxChildElementIndex = (index << 1) + 1;
        if (rightIndex < self.heapSize && [self compareElement:leftElement to:self.array[rightIndex]] < 0) {
            maxChildElementIndex = rightIndex;
        }
        
        if ([self compareElement:indexElement to:self.array[maxChildElementIndex]] >= 0) {
            break;
        }
        self.array[index] = self.array[maxChildElementIndex];
        index = maxChildElementIndex;
    }
    self.array[index] = indexElement;
}

@end

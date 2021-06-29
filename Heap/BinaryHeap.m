//
//  BinaryHeap.m
//  dataStruct
//
//  Created by 张森 on 2021/5/26.
//

#import "BinaryHeap.h"

@interface BinaryHeap()

@property (nonatomic, copy) NSMutableArray<id<Compare>> *array;

@end

@implementation BinaryHeap

+ (instancetype)binaryHeap:(NSArray<id<Compare>> *)elements {
    
    BinaryHeap *heap = [[BinaryHeap alloc] init];
    if ([elements count] > 0) {
        
        for (id<Compare> element in elements) {
            [heap.array addObject:element];
        }
        [heap _heapify];
    }
    return heap;
}

- (NSInteger)size {
    
    return [self.array count];
}
- (BOOL)isEmpty {
    
    return [self size] == 0;
}
- (void)clear {
    
    [self.array removeAllObjects];
}
// 大顶堆
- (void)add:(id<Compare>)element {
    
    [self.array addObject:element];
    [self _siftUp:[self size] - 1];
}

- (id<Compare>)remove {
    
    if ([self size] == 0) {
        return nil;
    }
    id<Compare> firstElement = [self.array firstObject];
    self.array[0] = [self.array lastObject];
    [self.array removeLastObject];
    [self _siftDown:0];
    return firstElement;
}

- (void)replace:(id<Compare>)element {
    
    if ([self size] == 0) {
        return;
    }
    self.array[0] = element;
    if ([self size] > 1) {
        [self _siftDown:0];
    }
}
- (id<Compare>)get {
    
    if ([self isEmpty]) {
        return nil;
    }
    return [self.array firstObject];
}

- (NSMutableArray *)array {
    
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

/// 上滤
/// @param index index
- (void)_siftUp:(NSInteger)index {
    
    if (index == 0 || index >= [self size]) {
        return;
    }
    id<Compare> element = self.array[index];
    while (index > 0) {
        NSInteger pIndex = (index - 1) >> 1;
        if ([element compareTo:self.array[pIndex]] <= 0) {
            // 当前节点比父节点小,直接退出
            break;
        }
        self.array[index] = self.array[pIndex];
        
        index = pIndex;
    }
    self.array[index] = element;
}

/// 下滤
/// @param index index
- (void)_siftDown:(NSInteger)index {
    
    // 下滤的位置必须是非叶子节点
    // 完全二叉树的非叶子节点个数是总节点个数的一半
    NSInteger half = [self size] >> 1;
    
    id<Compare> indexElement = self.array[index];
    while (index < half) {
        // 能到这里来,说明有叶子节点
        // 有两种情况,1.左右节点都存在;2.只有左节点
        id<Compare> leftElement = self.array[(index << 1) + 1];
        NSInteger rightIndex = (index << 1) + 2;
        NSInteger maxChildElementIndex = (index << 1) + 1;
        if (rightIndex < [self size] && [leftElement compareTo:self.array[rightIndex]] < 0) {
            maxChildElementIndex = rightIndex;
        }
        
        if ([indexElement compareTo:self.array[maxChildElementIndex]] >= 0) {
            break;
        }
        self.array[index] = self.array[maxChildElementIndex];
        index = maxChildElementIndex;
    }
    self.array[index] = indexElement;
}

- (void)_heapify {
    
    // 1.自上而下的上滤
    // 复杂度O(nlogn)
//    for (NSInteger index = 1; index < [self size]; index ++) {
//        [self _siftUp:index];
//    }
    // 2.自下而上的下滤
    // 复杂度O(n)
    // 从第一个非叶子节点开始下滤
    for (NSInteger index = ([self size] >> 1) - 1; index >= 0; index --) {
        [self _siftDown:index];
    }
}

- (NSString *)description
{
    NSString *str = @"\n";
    for (NSInteger index = 0; index < [self size]; index ++) {
        str = [NSString stringWithFormat:@"%@%@(%@)\n", str, self.array[index], index > 0 ? self.array[(index - 1) >> 1] : nil];
    }
    return str;
}

@end

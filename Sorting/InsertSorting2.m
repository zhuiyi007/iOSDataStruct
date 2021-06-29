//
//  InsertSorting2.m
//  dataStruct
//
//  Created by 张森 on 2021/6/7.
//

#import "InsertSorting2.h"

@implementation InsertSorting2

- (void)sort {
    
    for (NSInteger index = 1; index < [self.array count]; index ++) {
        
        // 二分查找需要插入的位置
        NSInteger insertIndex = [self _getInsertIndex:index];
        NSNumber *tmpNum = self.array[index];
        // 从后往前挪动元素
        for (NSInteger index1 = index; index1 > insertIndex; index1--) {
            self.array[index1] = self.array[index1 - 1];
        }
        // 插入当前元素
        self.array[insertIndex] = tmpNum;
    }
}

- (NSInteger)_getInsertIndex:(NSInteger)index {
    
    NSInteger begin = 0;
    NSInteger end = index;
    NSInteger mid = (begin + end) >> 1;
    while (begin < end) {
        
        if ([self compare:index to:mid] < 0) {
            end = mid;
        } else {
            begin = mid + 1;
        }
        mid = (begin + end) >> 1;
    }
    return begin;
}

@end

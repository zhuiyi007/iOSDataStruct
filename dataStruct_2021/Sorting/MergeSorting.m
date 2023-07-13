//
//  MergeSorting.m
//  dataStruct
//
//  Created by 张森 on 2021/6/7.
//

#import "MergeSorting.h"

@implementation MergeSorting {
    NSMutableArray <NSNumber *>*_tempArray;
}

- (void)sort {
    
    _tempArray = [NSMutableArray array];
    [self _sort:0 end:[self.array count]];
}

- (void)_sort:(NSUInteger)begin end:(NSUInteger)end {
    
    if (end - begin < 2) {
        return;
    }
    NSInteger mid = (end + begin) >> 1;
    // 先进行拆分
    [self _sort:begin end:mid];
    [self _sort:mid end:end];
    // 在进行合并
    [self _merge:begin mid:mid end:end];
}

- (void)_merge:(NSUInteger)begin mid:(NSUInteger)mid end:(NSUInteger)end {
    
    NSUInteger lBegin = 0, lEnd = mid - begin;
    NSUInteger rBegin = mid, rEnd = end;
    NSUInteger arrayBegin = begin;
    
    for (NSInteger index = lBegin; index < lEnd; index ++) {
        // 备份左边数据
        _tempArray[index] = self.array[begin + index];
    }
    
    // 左边没有结束的时候进行遍历
    while (lBegin < lEnd) {
        if (rBegin < rEnd && [self compareElement:self.array[rBegin] to:_tempArray[lBegin]] </*加=会变为不稳定排序*/ 0) {
            // 右边比左边小
            // 拿右边的值覆盖原值
            self.array[arrayBegin++] = self.array[rBegin++];
        } else {
            
            // 左边比右边小
            // 拿左边的值覆盖右边
            self.array[arrayBegin++] = _tempArray[lBegin++];
        }
    }
}

@end

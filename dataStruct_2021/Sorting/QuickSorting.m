//
//  QuickSorting.m
//  dataStruct
//
//  Created by 张森 on 2021/6/8.
//

#import "QuickSorting.h"

@implementation QuickSorting
- (void)sort {
    
    [self _sort:0 end:[self.array count]];
}

- (void)_sort:(NSUInteger)begin end:(NSUInteger)end {
    
    if (end - begin < 2) {
        return;
    }
    NSUInteger axisIndex = [self _getAxisIndex:begin end:end];
    [self _sort:begin end:axisIndex];
    [self _sort:axisIndex + 1 end:end];
}

- (NSUInteger)_getAxisIndex:(NSUInteger)begin end:(NSUInteger)end {
    
    // 将原先的左闭右开转为左闭右闭
    // [begin, end) -> [begin, end]
    end--;
    // 先备份轴点元素
    NSNumber *axisElement = self.array[begin];
    // 当begin和end不重合时进行循环
    while (begin < end) {
        
        while (begin < end) {
            // 先从右往左合并
            if ([self compareElement:axisElement to:self.array[end]] < /*此处最好不加=,加=后,遇到相同的元素不会发生交换,则有可能构造出来的轴点极度不平衡,容易发生O(n^2)的复杂度*/0) {
                // 遇到比axisElement大的元素
                // 即不需要挪动元素的位置
                // 则退出此循环
                end--;
                break;
            } else {
                self.array[begin++] = self.array[end];
            }
        }
        while (begin < end) {
            
            // 从左往右合并
            if ([self compareElement:axisElement to:self.array[begin]] > 0) {
                // 遇到比axisElement小的元素
                // 即不需要挪动元素的位置
                // 则退出此循环
                begin++;
                break;
            } else {
                
                self.array[end--] = self.array[begin];
            }
        }
    }
    // 退出循环时begin == end == 轴点位置
    // 覆盖备份的轴点元素
    self.array[begin] = axisElement;
    return begin;
}
@end

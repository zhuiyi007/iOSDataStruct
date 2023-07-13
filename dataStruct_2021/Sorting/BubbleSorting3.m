//
//  BubbleSorting3.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "BubbleSorting3.h"

@implementation BubbleSorting3
- (void)sort {
            
    for (NSInteger end = [self.array count]; end > 0; end --) {
        // 记录最后一次交换的位置,后续的遍历会从这个位置结束
        NSInteger sortedIndex = 0;
        for (NSInteger index = 1; index < end; index ++) {
            if ([self compare:index to:(index - 1)] < 0) {
                [self exchange:index to:(index - 1)];
                sortedIndex = index;
            }
        }
        // 循环完这次后,end还会--,因此要加1
        end = sortedIndex + 1;
    }
}
@end

//
//  BubbleSorting2.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "BubbleSorting2.h"

@implementation BubbleSorting2
- (void)sort {
    
    for (NSInteger end = [self.array count]; end > 0; end --) {
        BOOL sorted = true;
        for (NSInteger index = 1; index < end; index ++) {
            if ([self compare:index to:(index - 1)] < 0) {
                [self exchange:index to:(index - 1)];
                sorted = false;
            }
        }
        if (sorted) {
            // 如果某一次扫描之后发现已经有序了,就不需要在循环比较了
            break;
        }
    }
}
@end

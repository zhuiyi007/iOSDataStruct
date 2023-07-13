//
//  BubbleSorting.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "BubbleSorting.h"
#import "SortingTools.h"

@implementation BubbleSorting

- (void)sort {
    
    for (NSInteger end = [self.array count]; end > 0; end --) {
        for (NSInteger index = 1; index < end; index ++) {
            if ([self compare:index to:(index - 1)] </*加=即变为不稳定排序*/ 0) {
                [self exchange:index to:(index - 1)];
            }
        }
    }
}

@end

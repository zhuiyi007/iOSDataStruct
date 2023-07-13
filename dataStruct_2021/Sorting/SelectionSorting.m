//
//  SelectionSorting.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "SelectionSorting.h"
#import "SortingTools.h"

@implementation SelectionSorting

- (void)sort {
    
    for (NSInteger end = [self.array count] - 1; end > 0; end --) {
        NSInteger maxIndex = 0;
        for (NSInteger index = 1; index <= end; index ++) {
            if ([self compare:maxIndex to:index] <=/*去掉=即变为不稳定排序*/ 0) {
                maxIndex = index;
            }
        }
        [self exchange:maxIndex to:end];
    }
}

@end

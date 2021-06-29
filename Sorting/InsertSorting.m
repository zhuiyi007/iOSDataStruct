//
//  InsertSorting.m
//  dataStruct
//
//  Created by 张森 on 2021/6/7.
//

#import "InsertSorting.h"

@implementation InsertSorting

- (void)sort {
    
    for (NSInteger index = 1; index < [self.array count]; index ++) {
        
        NSInteger end = index;
        while (end > 0) {
            if ([self compare:end - 1 to:end] > 0) {
                
                [self exchange:end - 1 to:end];
            }
            end --;
        }
    }
}

@end

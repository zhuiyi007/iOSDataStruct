//
//  LongestIncreaseSubArray.m
//  dataStruct
//
//  Created by 张森 on 2021/6/19.
//  最长上升子序列

#import "LongestIncreaseSubArray.h"

@implementation LongestIncreaseSubArray

+ (void)run {
    
    NSLog(@"%d", [self longestIncreaseSubArray:@[[NSNumber numberWithInt:10], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1], [NSNumber numberWithInt:7], [NSNumber numberWithInt:101], [NSNumber numberWithInt:18]]]);
}

+ (int)longestIncreaseSubArray:(NSArray <NSNumber *>*)array {
    
    NSMutableArray <NSNumber *>*dpArray = [NSMutableArray array];
    int max = 1;
    for (NSInteger index = 0; index < [array count]; index ++) {
        
        [dpArray addObject:[NSNumber numberWithInt:1]];
        for (NSInteger index1 = 0; index1 < index; index1++) {
            
            if ([array[index] compare:array[index1]] == NSOrderedDescending/*array[index] > array[index1]*/) {
                
                if ([dpArray[index] intValue] - [dpArray[index1] intValue] < 1) {
                    
                    dpArray[index] = @([dpArray[index1] intValue] + 1);
                }
            }
        }
        max = MAX(max, [dpArray[index] intValue]);
    }
    return max;
}
@end

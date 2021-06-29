//
//  MaxSubArray.m
//  dataStruct
//
//  Created by 张森 on 2021/6/18.
//  最大连续子序列和

#import "MaxSubArray.h"

@implementation MaxSubArray
+ (void)run {
    
    NSLog(@"%ld", [self maxSubArray1:@[[NSNumber numberWithInt:-2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:-3], [NSNumber numberWithInt:4], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:1], [NSNumber numberWithInt:-5], [NSNumber numberWithInt:4]]]);
}

/// 优化空间复杂度,去掉dp数组
+ (NSInteger)maxSubArray1:(NSArray <NSNumber *>*)array {
    
    int dp = [array[0] intValue];
    int max = dp;
    for (NSInteger index = 1; index < [array count]; index++) {
        if (dp < 0) {
            dp = [array[index] intValue];
        } else {
            dp += [array[index] intValue];
        }
        max = MAX(max, dp);
    }
    return max;
}

+ (NSInteger)maxSubArray:(NSArray <NSNumber *>*)array {
    
    // 存放array[i]位置的最大连续子序列和
    NSMutableArray <NSNumber *>*dpArray = [NSMutableArray array];
    [dpArray addObject:array[0]];
    for (NSInteger index = 1; index < [array count]; index++) {
        if ([dpArray[index - 1] intValue] < 0) {
            [dpArray addObject:array[index]];
        } else {
            [dpArray addObject:@([dpArray[index - 1] intValue] + [array[index] intValue])];
        }
    }
    NSInteger max = [dpArray[0] intValue];
    for (NSInteger index = 1; index < [dpArray count]; index ++) {
        
        max = MAX(max, [dpArray[index] intValue]);
    }
    return max;
}
@end

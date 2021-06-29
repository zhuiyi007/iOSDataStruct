//
//  LongestCommonSubsequence.m
//  dataStruct
//
//  Created by 张森 on 2021/6/19.
//  最长公共子序列

#import "LongestCommonSubsequence.h"

@implementation LongestCommonSubsequence
+ (void)run {
    
    NSLog(@"%ld", (long)[self longestCommonSubsequence:@[@(1),@(3),@(5),@(9),@(10)] array2:@[@(1),@(4),@(9),@(10)]]);
}

// 再次优化空间复杂度,使用一维数组,并且使用较短的数列来初始化一维数组
+ (NSInteger)longestCommonSubsequence:(NSArray <NSNumber *>*)array1 array2:(NSArray <NSNumber *>*)array2 {
    
    // 判断数组长度大小,以长度较短的数组作为列
    NSArray <NSNumber *>* rowArray = array1;
    NSArray <NSNumber *>* colArray = array2;
    if ([array1 count] < [array2 count]) {
        
        rowArray = array2;
        colArray = array1;
    }
    
    // dpArray[i][j]代表以array1[i]和array2[j]结尾的最长公共子序列
    // 初始化数组以长度较短的数组长度来初始化
    NSMutableArray <NSNumber *>* dpArray = [NSMutableArray array];
    
    for (NSInteger j = 0; j <= [colArray count]; j ++) {
        
        [dpArray addObject:@(0)];
    }
    
    for (NSInteger i = 1; i <= [rowArray count]; i ++) {
        NSInteger cur = 0;
        for (NSInteger j = 1; j <= [colArray count]; j++) {
            NSInteger leftTop = cur;
            cur = [dpArray[j] integerValue];
            
            if ([rowArray[i - 1] compare:colArray[j - 1]] == NSOrderedSame) {
                // 如果遍历到两个元素相等,则最长公共子序列加一
                dpArray[j] = @(leftTop + 1);
            } else {
                // 如果不相等,则取之前遍历过元素的最大值
                dpArray[j] = @(MAX([dpArray[j - 1] integerValue], [dpArray[j] integerValue]));
            }
        }
    }
    return [dpArray[[array2 count]] integerValue];
}

// 优化空间复杂度,改用两行的滚动数组
+ (NSInteger)longestCommonSubsequence2:(NSArray <NSNumber *>*)array1 array2:(NSArray <NSNumber *>*)array2 {
    
    // dpArray[i][j]代表以array1[i]和array2[j]结尾的最长公共子序列
    NSMutableArray <NSMutableArray *>* dpArray = [[NSMutableArray alloc] initWithObjects:[NSMutableArray array], [NSMutableArray array], nil];
    
    for (NSInteger i = 0; i < 2; i++) {
        
        for (NSInteger j = 0; j <= [array2 count]; j ++) {
            
            [dpArray[i] addObject:@(0)];
        }
    }
    
    for (NSInteger i = 1; i <= [array1 count]; i ++) {
        // 滚动使用两行数组来进行记录
        NSInteger row = i & 1;
        NSInteger prevRow = (i - 1) & 1;
        for (NSInteger j = 1; j <= [array2 count]; j++) {
            if ([array1[i - 1] compare:array2[j - 1]] == NSOrderedSame) {
                // 如果遍历到两个元素相等,则最长公共子序列加一
                dpArray[row][j] = @([dpArray[prevRow][j - 1] integerValue] + 1);
            } else {
                // 如果不相等,则取之前遍历过元素的最大值
                dpArray[row][j] = @(MAX([dpArray[row][j - 1] integerValue], [dpArray[prevRow][j] integerValue]));
            }
        }
    }
    return [dpArray[1][[array2 count]] integerValue];
}

+ (NSInteger)longestCommonSubsequence1:(NSArray <NSNumber *>*)array1 array2:(NSArray <NSNumber *>*)array2 {
    
    // dpArray[i][j]代表以array1[i]和array2[j]结尾的最长公共子序列
    NSMutableArray <NSMutableArray *>* dpArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= [array1 count]; i ++) {
        NSMutableArray <NSNumber *>*tmpArray = [NSMutableArray array];
        [dpArray addObject:tmpArray];
        for (NSInteger j = 0; j <= [array2 count]; j++) {
            [tmpArray addObject:@(0)];
            if (i > 0 && j > 0) {
                if ([array1[i - 1] compare:array2[j - 1]] == NSOrderedSame) {
                    // 如果遍历到两个元素相等,则最长公共子序列加一
                    dpArray[i][j] = @([dpArray[i - 1][j - 1] integerValue] + 1);
                } else {
                    // 如果不相等,则取之前遍历过元素的最大值
                    dpArray[i][j] = @(MAX([dpArray[i][j - 1] integerValue], [dpArray[i - 1][j] integerValue]));
                }
            }
        }
    }
    return [dpArray[[array1 count]][[array2 count]] integerValue];
}
@end

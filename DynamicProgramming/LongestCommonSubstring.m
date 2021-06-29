//
//  LongestCommonSubstring.m
//  dataStruct
//
//  Created by 张森 on 2021/6/21.
//  最长公共子串(连续子序列)

#import "LongestCommonSubstring.h"

@implementation LongestCommonSubstring
+ (void)run {
    
    NSLog(@"%ld", [self longestCommonSubsequence:@"ABBDCABBA" string2:@"ABBA"]);
}

/// 优化成一维数组
+ (NSInteger)longestCommonSubsequence:(NSString *)string1 string2:(NSString *)string2 {
    
    
    NSString *colStr = string1;
    NSString *rowStr = string2;
    if ([string1 length] > [string2 length]) {
        colStr = string2;
        rowStr = string1;
    }
    NSMutableArray <NSNumber *>*dpArray = [NSMutableArray array];
    for (NSInteger index = 0; index <= [colStr length]; index++) {
        [dpArray addObject:@(0)];
    }
    
    NSInteger max = 0;
    NSInteger cur = 0;
    for (NSInteger i = 1; i <= [rowStr length]; i ++) {
        for (NSInteger j = 1; j <= [colStr length]; j ++) {
            
            NSInteger leftTop = cur;
            cur = [dpArray[j] integerValue];
            
            if ([[string1 substringWithRange:NSMakeRange(i - 1, 1)] isEqualToString:[string2 substringWithRange:NSMakeRange(j - 1, 1)]]) {
                
                dpArray[j] = @(leftTop + 1);
                max = MAX(max, [dpArray[j] integerValue]);
            } else {
                
                dpArray[j] = @(0);
            }
        }
    }
    return max;
}

+ (NSInteger)longestCommonSubsequence2:(NSString *)string1 string2:(NSString *)string2 {
    
    NSMutableArray <NSMutableArray <NSNumber *>*>*dpArray = [NSMutableArray array];
    NSInteger max = 0;
    for (NSInteger i = 0; i <= [string1 length]; i ++) {
        NSMutableArray <NSNumber *>*tmpArray = [NSMutableArray array];
        [dpArray addObject:tmpArray];
        for (NSInteger j = 0; j <= [string2 length]; j ++) {
            [tmpArray addObject:@(0)];
            if (i > 0 && j > 0) {
                if ([[string1 substringWithRange:NSMakeRange(i - 1, 1)] isEqualToString:[string2 substringWithRange:NSMakeRange(j - 1, 1)]]) {
                    
                    dpArray[i][j] = @([dpArray[i - 1][j - 1] integerValue] + 1);
                    max = MAX(max, [dpArray[i][j] integerValue]);
                }
            }
        }
    }
    return max;
}
@end

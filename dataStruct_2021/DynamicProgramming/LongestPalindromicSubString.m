//
//  LongestPalindromicSubString.m
//  dataStruct
//
//  Created by 张森 on 2021/6/28.
//  最长回文子串

#import "LongestPalindromicSubString.h"

@implementation LongestPalindromicSubString
+ (void)run {
    
    NSLog(@"%@", [self longestPalindromicSubString:@"bbabad"]);
}

/// 动态规划的思想
+ (NSString *)longestPalindromicSubString:(NSString *)str {
    
    // dpArray[i][j]代表str[i, j]是否是回文串
    NSMutableArray <NSMutableArray *>*dpArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [str length]; i ++) {
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        [dpArray addObject:tmpArray];
        for (NSInteger j = 0; j < [str length]; j++) {
            [tmpArray addObject:@(NO)];
        }
    }
    
    
    NSInteger i = 0, j = 0;
    // 最长回文串的开始点和长度
    NSInteger begin = 0, length = 1;
    while (j < [str length]) {
        
        if (i == j) {
            // 单字符子串
            dpArray[i][j] = @(YES);
        } else if (j - i == 1 && [[str substringWithRange:NSMakeRange(i, 1)] isEqualToString:[str substringWithRange:NSMakeRange(j, 1)]]) {
            // 双字符子串,如果两个字符相等,则赋为YES
            dpArray[i][j] = @(YES);
        } else {
            // 其他情况
            if ([dpArray[i + 1][j - 1] boolValue] == YES && [[str substringWithRange:NSMakeRange(i, 1)] isEqualToString:[str substringWithRange:NSMakeRange(j, 1)]]) {
                // 如果当前子串去掉头尾字符后是回文串,且头尾字符相等,则当前子串是回文串
                dpArray[i][j] = @(YES);
            }
        }
        
        if ([dpArray[i][j] boolValue] == YES && j - i > length) {
            length = j - i;
            begin = i;
        }
        
        if (j == [str length] - 1) {
            // 循环完了一次对角线
            j = j - i + 1;
            i = 0;
            continue;
        }
        i++;
        j++;
    }
    return [str substringWithRange:NSMakeRange(begin, length + 1)];
}
@end

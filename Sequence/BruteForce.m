//
//  BruteForce.m
//  dataStruct
//
//  Created by 张森 on 2021/6/25.
//  蛮力匹配字符串

#import "BruteForce.h"

@implementation BruteForce
+ (void)run {
    
    assert([self indexOf:@"Hello World" pattern:@"H"] == 0);
    assert([self indexOf:@"Hello World" pattern:@"c"] == -1);
    assert([self indexOf:@"Hello World" pattern:@"or"] == 7);
    assert([self indexOf:@"Hello World" pattern:@"d"] == 10);
    assert([self indexOf:@"Hello World" pattern:@"dad"] == -1);
}

/// 继续优化蛮力方法,提前退出
+ (NSInteger)indexOf:(NSString *)text pattern:(NSString *)pattern {
    
    NSInteger tlen = [text length], plen = [pattern length];
    if (!text || !pattern || tlen == 0 || plen == 0) {
        return -1;
    }
    if (plen > tlen) {
        return -1;
    }
    
    for (NSInteger ti = 0; ti <= tlen - plen; ti++) {
        NSInteger pi = 0;
        for (; pi < plen; pi++) {
            if (![[text substringWithRange:NSMakeRange(ti + pi, 1)] isEqualToString:[pattern substringWithRange:NSMakeRange(pi, 1)]]) {
                break;
            }
        }
        if (pi == plen) {
            return ti;
        }
    }
    return -1;
}

/// 优化蛮力方法
+ (NSInteger)indexOf2:(NSString *)text pattern:(NSString *)pattern {
    
    NSInteger tlen = [text length], plen = [pattern length];
    if (!text || !pattern || tlen == 0 || plen == 0) {
        return -1;
    }
    if (plen > tlen) {
        return -1;
    }
    
    NSInteger ti = 0, pi = 0;
    while (pi < plen && ti - pi <= tlen - plen/*当模式串往后移动超过匹配串时,可以直接退出*/) {
        
        if ([[text substringWithRange:NSMakeRange(ti, 1)] isEqualToString:[pattern substringWithRange:NSMakeRange(pi, 1)]]) {
            // 字符相等
            ti++;
            pi++;
        } else {
            // 字符不相等,回到原点重新匹配
            ti -= pi - 1;
            pi = 0;
        }
    }
    
    return (pi == plen) ? ti - pi : -1;
}

+ (NSInteger)indexOf1:(NSString *)text pattern:(NSString *)pattern {
    
    NSInteger tlen = [text length], plen = [pattern length];
    if (!text || !pattern || tlen == 0 || plen == 0) {
        return -1;
    }
    if (plen > tlen) {
        return -1;
    }
    
    NSInteger ti = 0, pi = 0;
    while (ti < tlen && pi < plen) {
        
        if ([[text substringWithRange:NSMakeRange(ti, 1)] isEqualToString:[pattern substringWithRange:NSMakeRange(pi, 1)]]) {
            // 字符相等
            ti++;
            pi++;
        } else {
            // 字符不相等,回到原点重新匹配
            ti -= pi - 1;
            pi = 0;
        }
    }
    
    return (pi == plen) ? ti - pi : -1;
}
@end

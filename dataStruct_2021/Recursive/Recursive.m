//
//  Recursive.m
//  dataStruct
//
//  Created by 张森 on 2021/6/10.
//

#import "Recursive.h"

@implementation Recursive

+ (void)run {
//    for (NSInteger index = 1; index <= 45; index++) {
//        NSLog(@"%ld, %ld", index, [self climbStairs:index]);
//        NSLog(@"-------------");
//    }
    
    for (NSInteger index = 1; index <= 5; index ++) {
        
        [self hanoi:index columnLeft:@"A" columnMiddle:@"B" columnRight:@"C"];
        NSLog(@"--------------");
    }
}
+ (NSInteger)fibonacci:(NSInteger)n {
    
//    40, 102334155
//    -------------
//    41, 165580141
//    -------------
//    42, 267914296
//    -------------
//    43, 433494437
//    -------------
//    44, 701408733
//    -------------
//    45, 1134903170
//    -------------
    
    // 常规递归调用方法,时间复杂度为O(2^n), 空间复杂度为O(n)(调用深度)
//    if (n <= 2) {
//        return 1;
//    }
//    return [self fibonacci:(n-1)] + [self fibonacci:(n-2)];
    
    // 非递归调用,时间复杂度为O(n), 空间复杂度为O(1)
    if (n <= 2) {
        return 1;
    }
    NSInteger first = 1;
    NSInteger second = 1;
    NSInteger num = 0;
    for (NSInteger index = 3; index <= n; index++) {
        
        num = first + second;
        first = second;
        second = num;
    }
    return num;
}

/// 一次可以走1阶或者2阶,n阶楼梯一共有多少种走法
+ (NSInteger)climbStairs:(NSInteger)n {
    
    // 常规递归调用的写法, 时间复杂度为O(2^n), 空间复杂度为O(n)(调用深度)
    // 同fibonacci,可以优化为非递归调用,时间复杂度为O(n), 空间复杂度为O(1)
    // 1阶台阶有1种走法,2阶台阶有2种走法
    if (n <= 2) {
        return n;
    }
    // n阶台阶可以拆分为(n - 1)阶台阶的走法加(n - 2)阶台阶的走法
    return [self climbStairs:n - 1] + [self climbStairs:n - 2];
}

/// 汉诺塔, 将n个盘子从Left柱子移动到Right柱子, 要求每次移动时, 只能将小盘子压到大盘子上
/// @param n 盘子的数量
/// @param columnLeft 左边柱子的名称
/// @param columnMiddle 中间柱子的名称
/// @param columnRight 右边柱子的名称
+ (void)hanoi:(NSInteger)n columnLeft:(NSString *)columnLeft columnMiddle:(NSString *)columnMiddle columnRight:(NSString *)columnRight {
    if (n == 1) {
        NSLog(@"%ld 号盘子从 %@ 移动到 %@", n, columnLeft, columnRight);
        return;
    }
    [self hanoi:n-1 columnLeft:columnLeft columnMiddle:columnRight columnRight:columnMiddle];
    NSLog(@"%ld 号盘子从 %@ 移动到 %@", n, columnLeft, columnRight);
    [self hanoi:n-1 columnLeft:columnMiddle columnMiddle:columnLeft columnRight:columnRight];
}
@end

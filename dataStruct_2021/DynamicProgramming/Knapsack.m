//
//  Knapsack.m
//  dataStruct
//
//  Created by 张森 on 2021/6/23.
//  0-1背包问题

#import "Knapsack.h"

@implementation Knapsack
+ (void)run {
    
    NSLog(@"%ld", [self knapsackValue:@[@(6), @(3), @(5), @(4), @(6)] weights:@[@(2), @(2), @(6), @(5), @(4)] capacity:10]);
}

/// 题目内容改为刚好凑满capacity
+ (NSInteger)knapsackValue:(NSArray <NSNumber *>*)values weights:(NSArray <NSNumber *>*)weights capacity:(NSInteger)capacity {
 
    if (capacity <= 0) {
        return -1;
    }
    if (!values || [values count] == 0) {
        return -1;
    }
    if (!weights || [weights count] == 0) {
        return -1;
    }
    
    NSMutableArray <NSNumber *>* dpArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= capacity; i++) {
        // 原始数据中填充为负无穷
        [dpArray addObject:@(NSIntegerMin)];
    }
    for (NSInteger i = 1; i <= [values count]; i++) {
        
        for (NSInteger j = capacity; j >= [weights[i - 1] integerValue]; j --) {
            // 覆盖数组元素的时候从右往左进行覆盖,不在需要额外的数据记录leftTop
            // 如果容量小于当前要拿的物品容量,则不拿,不用进行值覆盖
            if (j < [weights[i - 1] integerValue]) continue;
            // 当前容量大于等于要拿物品的容量,此时有两种情况,拿或者不拿
            // 1.不拿此物品
            NSInteger untake = [dpArray[j] integerValue];
            // 2.拿此物品
            // 找到背包重量为j - 当前物品重量时的最大价值,加上当前物品的价值
            NSInteger take = [dpArray[j - [weights[i - 1] integerValue]] integerValue] + [values[i - 1] integerValue];
            // 3.取较大的值进行赋值
            dpArray[j] = @(MAX(take, untake));
        }
    }
    return [dpArray[capacity] integerValue] < 0 ? -1 : [dpArray[capacity] integerValue];
}

/// 空间复杂度简化为一维数组
+ (NSInteger)knapsackValue3:(NSArray <NSNumber *>*)values weights:(NSArray <NSNumber *>*)weights capacity:(NSInteger)capacity {
 
    if (capacity <= 0) {
        return -1;
    }
    if (!values || [values count] == 0) {
        return -1;
    }
    if (!weights || [weights count] == 0) {
        return -1;
    }
    
    NSMutableArray <NSNumber *>* dpArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= capacity; i++) {
        [dpArray addObject:@(0)];
    }
    for (NSInteger i = 1; i <= [values count]; i++) {
        
        for (NSInteger j = capacity; j >= [weights[i - 1] integerValue]/*后面的值不需要再遍历了,因为不会被覆盖*/; j --) {
            // 覆盖数组元素的时候从右往左进行覆盖,不在需要额外的数据记录leftTop
            // 如果容量小于当前要拿的物品容量,则不拿,不用进行值覆盖
            if (j < [weights[i - 1] integerValue]) continue;
            // 当前容量大于等于要拿物品的容量,此时有两种情况,拿或者不拿
            // 1.不拿此物品
            NSInteger untake = [dpArray[j] integerValue];
            // 2.拿此物品
            // 找到背包重量为j - 当前物品重量时的最大价值,加上当前物品的价值
            NSInteger take = [dpArray[j - [weights[i - 1] integerValue]] integerValue] + [values[i - 1] integerValue];
            // 3.取较大的值进行赋值
            dpArray[j] = @(MAX(take, untake));
        }
    }
    return [dpArray[capacity] integerValue];
}

+ (NSInteger)knapsackValue2:(NSArray <NSNumber *>*)values weights:(NSArray <NSNumber *>*)weights capacity:(NSInteger)capacity {
 
    if (capacity <= 0) {
        return -1;
    }
    if (!values || [values count] == 0) {
        return -1;
    }
    if (!weights || [weights count] == 0) {
        return -1;
    }
    
    // dpArray[i][j]为容量j时,拿前i件物品时的最大价值
    NSMutableArray <NSMutableArray *>* dpArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= [values count]; i++) {
        NSMutableArray <NSNumber *>*tmpArray = [NSMutableArray array];
        [dpArray addObject:tmpArray];
        for (NSInteger j = 0; j <= capacity; j ++) {
            [tmpArray addObject:@(0)];
            if (i > 0 && j > 0) {
                if (j < [weights[i - 1] integerValue]) {
                    // 如果当前容量小于要拿的容量,则不能拿此物品,背包总价值为拿前i - 1件物品的价值
                    dpArray[i][j] = dpArray[i - 1][j];
                } else {
                    // 当前容量大于等于要拿物品的容量,此时有两种情况,拿或者不拿
                    // 1.不拿此物品
                    NSInteger untake = [dpArray[i - 1][j] integerValue];
                    // 2.拿此物品
                    // 找到背包重量为j - 当前物品重量时的最大价值,加上当前物品的价值
                    NSInteger take = [dpArray[i - 1][j - [weights[i - 1] integerValue]] integerValue] + [values[i - 1] integerValue];
                    // 3.取较大的值进行赋值
                    dpArray[i][j] = @(MAX(take, untake));
                }
            }
        }
    }
    return [dpArray[[weights count]][capacity] integerValue];
}
@end

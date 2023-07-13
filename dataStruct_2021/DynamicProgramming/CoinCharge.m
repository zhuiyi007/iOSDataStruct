//
//  CoinCharge.m
//  dataStruct
//
//  Created by 张森 on 2021/6/17.
//  找零钱

#import "CoinCharge.h"

@implementation CoinCharge

+ (void)run {
    
    NSLog(@"%ld", [self coinCharge3:41]);
}

/// 自底向上
+ (NSInteger)coinCharge3:(NSInteger)n {
    
    NSMutableArray *dpArray = [NSMutableArray array];
    NSMutableArray *faceArray = [NSMutableArray array];
    for (NSInteger index = 0; index <= n; index++) {
        [dpArray addObject:@(0)];
        [faceArray addObject:@(0)];
    }
    for (NSInteger index = 1; index <= n; index++) {
        NSInteger min = [dpArray[index - 1] integerValue];
        faceArray[index] = @(1);
        
        if (index >= 5 && [dpArray[index - 5] integerValue] < min) {
            min = [dpArray[index - 5] integerValue];
            faceArray[index] = @(5);
        }
        if (index >= 20 && [dpArray[index - 20] integerValue] < min) {
            min = [dpArray[index - 20] integerValue];
            faceArray[index] = @(20);
        }
        if (index >= 25 && [dpArray[index - 25] integerValue] < min) {
            min = [dpArray[index - 25] integerValue];
            faceArray[index] = @(25);
        }
        dpArray[index] = @(min + 1);
    }
    [self _print:faceArray faceCount:n];
    return [dpArray[n] integerValue];
}

+ (void)_print:(NSMutableArray *)faceArray faceCount:(NSInteger)faceCount {
    
    do {
        NSLog(@"%@", faceArray[faceCount]);
        faceCount = faceCount - [faceArray[faceCount] integerValue];
    }while (faceCount > 0);
}


/// 记忆化搜索
/// 把之前搜索的结果保留起来,防止重复计算
+ (NSInteger)coinCharge2:(NSInteger)n {
    
    if (n < 1) {
        return -1;
    }
    NSMutableArray *dpArray = [NSMutableArray array];
    for (NSInteger index = 0; index <= n; index++) {
        [dpArray addObject:@(0)];
    }
    NSSet *coins = [NSSet setWithArray:@[@(1), @(5), @(20), @(25)]];
    for (NSNumber *num in coins) {
        if ([num integerValue] < [dpArray count]) {
            dpArray[[num integerValue]] = @(1);
        }
    }
    return [self _coinCharge2:n dpArray:dpArray];
}

+ (NSInteger)_coinCharge2:(NSInteger)n dpArray:(NSMutableArray *)dpArray {
    
    if (n < 1) {
        return NSIntegerMax;
    }
    
    if ([dpArray[n] integerValue] == 0) {
        
        NSInteger min1 = MIN([self _coinCharge2:(n - 1) dpArray:dpArray], [self _coinCharge2:(n - 5) dpArray:dpArray]);
        NSInteger min2 = MIN([self _coinCharge2:(n - 20) dpArray:dpArray], [self _coinCharge2:(n - 25) dpArray:dpArray]);
        dpArray[n] = @(MIN(min1, min2) + 1);
    }
    return [dpArray[n] integerValue];
}



/// 暴力破解,自顶向下
+ (NSInteger)coinCharge1:(NSInteger)n {
    
    if (n < 1) {
        return NSIntegerMax;
    }
    if (n == 1 || n == 5 || n == 20 || n == 25) {
        return 1;
    }
    NSInteger min1 = MIN([self coinCharge1:n - 1], [self coinCharge1:n - 5]);
    NSInteger min2 = MIN([self coinCharge1:n - 20], [self coinCharge1:n - 25]);
    return MIN(min1, min2) + 1;
}

@end

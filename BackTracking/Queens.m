//
//  Queens.m
//  dataStruct
//
//  Created by 张森 on 2021/6/10.
//

#import "Queens.h"

@interface Queens ()
/// queens[i]中存放着第i行的queen在第几列
@property (nonatomic, strong) NSMutableArray *queens;
/// 共有多少种摆法
@property (nonatomic, assign) NSUInteger ways;
@end
@implementation Queens

+ (void)run {
    
    [[Queens new] placeQueen:8];
}

- (void)placeQueen:(NSInteger)count {
    
    if (count < 1) {
        return;
    }
    self.queens = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index ++) {
        self.queens[index] = @(-1);
    }
    self.ways = 0;
    // 从第0行开始摆
    [self _place:0];
    
    NSLog(@"%ld 皇后共有 %ld 种摆法", (long)count, (long)self.ways);
}

/// 在第row行摆放queen
/// @param row row
- (void)_place:(NSInteger)row {
    
    // 所有行都遍历完成
    if (row == [self.queens count]) {
//        NSLog(@"-------------------\n\n\n");
//        NSString *rowStr = @"";
//        for (NSInteger row = 0; row < [self.queens count]; row ++) {
//            for (NSInteger col = 0; col < [self.queens count]; col++) {
//                if ([self.queens[row] integerValue] == col) {
//                    rowStr = [NSString stringWithFormat:@"%@1 ", rowStr];
//                } else {
//                    rowStr = [NSString stringWithFormat:@"%@0 ", rowStr];
//                }
//            }
//            NSLog(@"%@\n\n\n", rowStr);
//            rowStr = @"";
//        }
        // 找到了可选方案
        self.ways++;
        return;
    }
    
    for (NSInteger col = 0; col < [self.queens count]; col ++) {
        
        if ([self _valid:row col:col]) {
            // 如果当前行和列能摆queen,则摆放queen
            self.queens[row] = @(col);
            // 开始摆放下一行
            [self _place:(row + 1)];
        }
    }
}

/// 判断row行col列是否能摆queen
- (BOOL)_valid:(NSInteger)row col:(NSInteger)col {
    
    for (NSInteger index = 0; index < row; index ++) {
        
        if ([self.queens[index] integerValue] == col) {
            // 如果某一行摆放的queen与当前列相等,则返回失败
//            NSLog(@"[%ld][%ld] = false", (long)row, (long)col);
            return NO;
        }
        if ((row - index) == abs((int)([self.queens[index] integerValue] - col))) {
            // 斜率相同(x1-x2)/(y1-y2) = 1/-1
            // 与原有的queen处于一条斜线上
//            NSLog(@"[%ld][%ld] = false", (long)row, (long)col);
            return NO;
        }
    }
//    NSLog(@"[%ld][%ld] = ture", (long)row, (long)col);
    return YES;
}

@end

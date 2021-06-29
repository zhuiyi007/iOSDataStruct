//
//  Queens3.m
//  dataStruct
//
//  Created by 张森 on 2021/6/10.
//

/**
 对Queen2的优化
 优化了cols, leftTop, rightTop的数据结构,改用字节来存储
 */

#import "Queens3.h"

@interface Queens3 ()
/// queens[i]中存放着第i行的queen在第几列(此优化中当前属性仅用作打印)
@property (nonatomic, strong) NSMutableArray *queens;
/// 共有多少种摆法
@property (nonatomic, assign) NSUInteger ways;
@end
@implementation Queens3
{
    /// 记录某一列是否有queen
    /// 用8位的空间来记录
    UInt8 _cols;
    /// 记录某条斜线上是否有queen(从左上到右下)
    /// 用16位的空间来记录
    UInt16 _leftTop;
    /// 记录某条斜线上是否有queen(从右上到左下)
    /// 用16位的空间来记录
    UInt16 _rightTop;
}

+ (void)run {
    
    [[Queens3 new] placeQueen:8];
}

- (void)placeQueen:(NSInteger)count {
    
    if (count < 1) {
        return;
    }
    _cols = 0b00000000;
    _leftTop = 0b0000000000000000;
    _rightTop = 0b0000000000000000;

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
        NSLog(@"-------------------\n\n\n");
        NSString *rowStr = @"";
        for (NSInteger row = 0; row < [self.queens count]; row ++) {
            for (NSInteger col = 0; col < [self.queens count]; col++) {
                if ([self.queens[row] integerValue] == col) {
                    rowStr = [NSString stringWithFormat:@"%@1 ", rowStr];
                } else {
                    rowStr = [NSString stringWithFormat:@"%@0 ", rowStr];
                }
            }
            NSLog(@"%@\n\n\n", rowStr);
            rowStr = @"";
        }
        // 找到了可选方案
        self.ways++;
        return;
    }
    
    for (NSInteger col = 0; col < [self.queens count]; col ++) {
        
        // 如果当前列已经有queen,则直接跳过
        if (_cols & (0b1 << col)) {
            continue;
        }
        // [0, 7]的序号为0, [7, 0]的序号为14
        NSInteger leftTopIndex = row - col + [self.queens count] - 1;
        // 如果当前左上到右下角的斜线已经有queen,则直接跳过
        if (_leftTop & (0b1 << leftTopIndex)) {
            continue;
        }
        // [0, 0]的序号为0, [7, 7]的序号为14
        NSInteger rightTopIndex = col + row;
        // 如果当前右上到左下角的斜线已经有queen,则直接跳过
        if (_rightTop & (0b1 << rightTopIndex)) {
            continue;
        }
        
        _cols |= (0b1 << col);
        _leftTop |= (0b1 << leftTopIndex);
        _rightTop |= (0b1 << rightTopIndex);

        // 如果当前行和列能摆queen,则摆放queen
        self.queens[row] = @(col);
        // 开始摆放下一行
        [self _place:(row + 1)];
        
        // 回溯之后,需要将之前的值重置为NO
        _cols &= (~(0b1 << col));
        _leftTop &= (~(0b1 << leftTopIndex));
        _rightTop &= (~(0b1 << rightTopIndex));
    }
}

@end

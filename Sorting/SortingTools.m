//
//  SortingTools.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "SortingTools.h"

@implementation SortingTools

+ (NSArray <NSNumber *>*)randomNumber:(NSInteger)count min:(NSUInteger)min max:(NSUInteger)max {
    
    if (count == 0 || max < min) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger index = 0; index < count; index ++) {
        [arr addObject:[NSNumber numberWithInt:(int)(min + (arc4random() % (max - min + 1)))]];
    }
    return [arr copy];
}

+ (NSString *)printSortArray:(NSArray *)arr {
    
    NSString *str = @"";
    for (id element in arr) {
        str = [NSString stringWithFormat:@"%@_%@", str, element];
    }
    return str;
}

/// 数组元素是否为升序
/// @param array array
+ (BOOL)isAsce:(NSMutableArray <NSNumber *>*)array {
    
    for (NSInteger index = 1; index < [array count]; index ++) {
        
        if ([array[index] integerValue] < [array[index - 1] integerValue]) {
            return NO;
        }
    }
    return YES;
}

/// 数组元素是否为降序
/// @param array array
+ (BOOL)isDsce:(NSMutableArray <NSNumber *>*)array {
    
    for (NSInteger index = 1; index < [array count]; index ++) {
        
        if (array[index] > array[index - 1]) {
            return NO;
        }
    }
    return YES;
}

+ (void)testTime:(void (^)(void))block {
    
    
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    
    NSLog(@">开始时间 = %f s", startTime);
    
    block();
    
    CFAbsoluteTime endTime =CFAbsoluteTimeGetCurrent();
    NSLog(@">结束时间 = %f s", endTime);
    NSLog(@">总耗时 = %f s", endTime - startTime);
    NSLog(@"----------------");
}

@end

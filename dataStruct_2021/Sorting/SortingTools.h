//
//  SortingTools.h
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortingTools : NSObject
+ (NSArray <NSNumber *>*)randomNumber:(NSInteger)count min:(NSUInteger)min max:(NSUInteger)max;

+ (NSString *)printSortArray:(NSArray *)arr;

+ (void)testTime:(void (^)(void))block;

/// 数组元素是否为升序
/// @param array array
+ (BOOL)isAsce:(NSMutableArray <NSNumber *>*)array;

/// 数组元素是否为降序
/// @param array array
+ (BOOL)isDsce:(NSMutableArray <NSNumber *>*)array;
@end

NS_ASSUME_NONNULL_END

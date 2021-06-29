//
//  Sort.h
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import <Foundation/Foundation.h>
#import "SortingTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject

@property (nonatomic, strong) NSMutableArray <NSNumber *>*array;

- (void)sort:(NSMutableArray <NSNumber *>*)arr;

- (void)sort:(NSMutableArray <NSNumber *>*)arr functionClass:(Sort *)functionClass, ...NS_REQUIRES_NIL_TERMINATION;

/// 交换两个位置的元素
/// @param index index
/// @param toIndex toIndex
- (void)exchange:(NSUInteger)index to:(NSUInteger)toIndex;

/// 比较两个位置的元素
/// return < 0 array[index] < array[toIndex]
/// return = 0 array[index] = array[toIndex]
/// return > 0 array[index] > array[toIndex]
/// @param index index
/// @param toIndex toIndex
- (NSInteger)compare:(NSUInteger)index to:(NSUInteger)toIndex;

/// 比较两个元素
/// return < 0 element < element2
/// return = 0 element = element2
/// return > 0 element > element2
/// @param element element
/// @param element2 element2
- (NSInteger)compareElement:(NSNumber *)element to:(NSNumber *)element2;
@end

NS_ASSUME_NONNULL_END

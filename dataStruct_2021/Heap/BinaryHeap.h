//
//  BinaryHeap.h
//  dataStruct
//
//  Created by 张森 on 2021/5/26.
//

#import <Foundation/Foundation.h>
#import "Compare.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryHeap : NSObject

/// 批量建堆
/// @param elements elements
+ (instancetype)binaryHeap:(NSArray<id<Compare>> *)elements;
/// 获取堆的大小
- (NSInteger)size;
/// 是否为空
- (BOOL)isEmpty;
/// 清空堆
- (void)clear;
/// 添加元素
/// @param element element
- (void)add:(id<Compare>)element;
/// 删除堆顶元素
- (id<Compare>)remove;
/// 删除堆顶元素,同时插入一个新元素
/// @param element element
- (void)replace:(id<Compare>)element;
/// 获取堆顶元素
- (id<Compare>)get;

@end

NS_ASSUME_NONNULL_END

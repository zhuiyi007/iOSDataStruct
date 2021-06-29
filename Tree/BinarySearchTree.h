//
//  BinarySearchTree.h
//  dataStruct
//
//  Created by 张森 on 2021/4/15.
//

#import <Foundation/Foundation.h>
#import "Compare.h"
#import "TreeCompartor.h"
#import "BinaryTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinarySearchTree : BinaryTree

/// 添加元素
/// @param element element
- (void)add:(id<Compare>)element;

/// 移除元素
/// @param element element
- (void)remove:(id<Compare>)element;

/// 是否包含元素
/// @param element element
- (BOOL)contains:(id<Compare>)element;

@end

NS_ASSUME_NONNULL_END

//
//  LinkListSet.h
//  dataStruct
//
//  Created by 张森 on 2021/4/25.
//

#import "LinkList.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinkListSet : NSObject

/// 清除所有元素
- (void)clear;

/// 元素的数量
- (NSInteger)size;

/// 是否为空
- (BOOL)isEmpty;

/// 是否包含某个元素
/// @param element element
- (BOOL)contains:(id)element;

/// 添加元素
/// @param element element
- (void)add:(id)element;

/// 删除某个元素
/// @param element element
- (void)remove:(id)element;

/// 遍历元素
/// @param element element
- (void)enumElement:(void(^)(id node, BOOL *isStop))element;

@end

NS_ASSUME_NONNULL_END

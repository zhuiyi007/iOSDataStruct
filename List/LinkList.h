//
//  LinkList.h
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSInteger NS_NOT_FOUND = -1;
@interface LinkList : NSObject

/// 清除所有元素
- (void)clear;

/// 元素的数量
- (NSInteger)size;

/// 是否为空
- (BOOL)isEmpty;

/// 是否包含某个元素
/// @param element element
- (BOOL)contains:(id)element;

/// 向尾部添加元素
/// @param element element
- (void)add:(id)element;

/// 获取某个位置的元素
/// @param index index
- (id)get:(NSInteger)index;

/// 设置某个位置的元素
/// @param index index
/// @param element element
- (void)set:(NSInteger)index element:(id)element;

/// 在某个位置插入元素
/// @param index index
/// @param element element
- (void)add:(NSInteger)index element:(id)element;

/// 删除某个位置的元素
/// @param index index
- (void)remove:(NSInteger)index;

/// 查看元素的索引
/// @param element element
- (NSInteger)indexOf:(id)element;

@end

NS_ASSUME_NONNULL_END

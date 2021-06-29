//
//  Queue.h
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Queue : NSObject

/// 获取队列
+ (instancetype)queue;

/// 队列长度
- (NSInteger)size;

/// 队列是否为空
- (BOOL)isEmpty;

/// 清空队列
- (void)clear;

/// 队列尾部加入元素
/// @param element element
- (void)push:(id)element;

/// 队列头部弹出元素
- (void)pop;

/// 队头元素
- (id)front;
@end

NS_ASSUME_NONNULL_END

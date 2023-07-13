//
//  Queue.m
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import "Queue.h"
#import "LinkList.h"

@interface Queue ()

@property (nonatomic, strong) LinkList *list;

@end

@implementation Queue

/// 获取队列
+ (instancetype)queue {
    
    Queue *queue = [[Queue alloc] init];
    queue.list = [[LinkList alloc] init];
    return queue;
}

/// 队列长度
- (NSInteger)size {
    
    return [self.list size];
}

/// 队列是否为空
- (BOOL)isEmpty {
    
    return [self.list isEmpty];
}

/// 清空队列
- (void)clear {
    
    [self.list clear];
    self.list = nil;
}

/// 队列尾部加入元素
/// @param element element
- (void)push:(id)element {
    
    [self.list add:element];
}

/// 队列头部弹出元素
- (void)pop {
    
    [self.list remove:0];
}

/// 队头元素
- (id)front {
    
    return [self.list get:0];
}

@end

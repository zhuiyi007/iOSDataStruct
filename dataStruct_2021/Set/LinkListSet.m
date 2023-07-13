//
//  LinkListSet.m
//  dataStruct
//
//  Created by 张森 on 2021/4/25.
//

#import "LinkListSet.h"
#import "LinkList.h"

@interface LinkListSet ()

@property (nonatomic, strong) LinkList *list;
@end

@implementation LinkListSet

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.list = [[LinkList alloc] init];
    }
    return self;
}

/// 清除所有元素
- (void)clear {
    
    [self.list clear];
}

/// 元素的数量
- (NSInteger)size {
    
    return [self.list size];
}

/// 是否为空
- (BOOL)isEmpty {
    
    return [self.list isEmpty];
}

/// 是否包含某个元素
/// @param element element
- (BOOL)contains:(id)element {
    
    return [self.list contains:element];
}

/// 添加元素
/// @param element element
- (void)add:(id)element {
    
    NSInteger index = [self.list indexOf:element];
    if (index == NS_NOT_FOUND) {
        
        // 不重复的元素
        [self.list add:element];
    } else {
        
        // 重复的元素,直接覆盖
        [self.list set:index element:element];
    }
}

/// 删除某个元素
/// @param element element
- (void)remove:(id)element {
    
    NSInteger index = [self.list indexOf:element];
    if (index != NS_NOT_FOUND) {
        
        [self.list remove:index];
    }
}

static BOOL _enumElementStop = NO;
/// 遍历元素
/// @param element element
- (void)enumElement:(void(^)(id node, BOOL *isStop))element {
    
    _enumElementStop = NO;
    if (!element) {
        return;;
    }
    for (NSInteger index = 0; index < [self size]; index ++) {
        
        if (!_enumElementStop) {
            
            element([self.list get:index], &_enumElementStop);
        } else {
            
            break;
        }
    }
}

@end

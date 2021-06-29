//
//  LinkList.m
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import "LinkList.h"

@interface LinkListNode : NSObject
/// 元素内容
@property (nonatomic, strong) id element;
/// 前一个元素
@property (nonatomic, strong, nullable) LinkListNode *prev;
/// 后一个元素
@property (nonatomic, strong, nullable) LinkListNode *next;
@end

@implementation LinkListNode

+ (instancetype)node:(id)element {
    
    LinkListNode *node = [[LinkListNode alloc] init];
    node.element = element;
    return node;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n%@ - %@ - %@\n", self.prev.element, self.element, self.next.element];
}
@end



@interface LinkList ()

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) LinkListNode *first;
@property (nonatomic, strong) LinkListNode *last;

@end

@implementation LinkList

/// 清除所有元素
- (void)clear {
    
    self.size = 0;
    self.first = nil;
    self.last = nil;
}

/// 元素的数量
- (NSInteger)size {
    
    return _size;
}

/// 是否为空
- (BOOL)isEmpty {
    
    return _size;
}

/// 是否包含某个元素
/// @param element element
- (BOOL)contains:(id)element {
    
    return [self indexOf:element] >= 0;
}

/// 向尾部添加元素
/// @param element element
- (void)add:(id)element {
    
    [self add:self.size element:element];
}

/// 获取某个位置的元素
/// @param index index
- (id)get:(NSInteger)index {
    
    LinkListNode *node;
    if (index < (self.size >> 1)) {
        // 在前一半
        node = self.first;
        for (NSInteger i = 0; i < index; i ++) {
            node = node.next;
        }
    } else {
        // 在后一半
        node = self.last;
        for (NSInteger i = self.size - 1; i > index; i --) {
            node = node.prev;
        }
    }
    return node.element;
}

/// 设置某个位置的元素
/// @param index index
/// @param element element
- (void)set:(NSInteger)index element:(id)element {
    
    LinkListNode *node = [LinkListNode node:element];
    if (index == self.size) {
        
        // 最后一个
        node.prev = self.last.prev;
        self.last.prev.next = node;
        self.last.prev = nil;
        
        self.last = node;
        return;
    }
    
    if (index == 0) {
        
        // 第一个
        node.next = self.first.next;
        self.first.next.prev = node;
        self.first.next = nil;
        
        self.first = node;
        return;
    }
    
    LinkListNode *tempNode;
    if (index < (self.size >> 1)) {
        // 在前一半
        tempNode = self.first;
        for (NSInteger i = 0; i < index; i ++) {
            tempNode = tempNode.next;
        }
    } else {
        // 在后一半
        tempNode = self.last;
        for (NSInteger i = self.size - 1; i > index; i --) {
            tempNode = tempNode.prev;
        }
    }
    node.prev = tempNode.prev;
    node.next = tempNode.next;
    
    tempNode.prev.next = node;
    tempNode.next.prev = node;
    
    tempNode.prev = nil;
    tempNode.next = nil;
}

/// 在某个位置插入元素
/// @param index index
/// @param element element
- (void)add:(NSInteger)index element:(id)element {
    
    LinkListNode *node = [LinkListNode node:element];
    if (self.size == 0) {
        // 没有元素
        self.last = node;
        self.first = node;
        self.size ++;
        return;
    }
    
    if (index == self.size) {
        
        // 最后一个
        self.last.next = node;
        node.prev = self.last;
        self.last = node;
        self.size ++;
        return;
    }
    
    if (index == 0) {
        
        // 第一个
        self.first.prev = node;
        node.next = self.first;
        self.first = node;
        self.size ++;
        return;
    }
    
    LinkListNode *tempNode;
    if (index < (self.size >> 1)) {
        // 在前一半
        tempNode = self.first;
        for (NSInteger i = 0; i < index; i ++) {
            tempNode = tempNode.next;
        }
    } else {
        // 在后一半
        tempNode = self.last;
        for (NSInteger i = self.size - 1; i > index; i --) {
            tempNode = tempNode.prev;
        }
    }
    node.prev = tempNode;
    node.next = tempNode.next;
    
    tempNode.next.prev = node;
    tempNode.next = node;
}

/// 删除某个位置的元素
/// @param index index
- (void)remove:(NSInteger)index {
    
    if (index == self.size - 1) {
        
        // 最后一个元素
        self.last = self.last.prev;
        self.last.next.prev = nil;
        self.last.next = nil;
        self.size --;
        return;
    }
    if (index == 0) {
        
        // 删除第一个元素
        self.first = self.first.next;
        self.first.prev.next = nil;
        self.first.prev = nil;
        self.size --;
        return;
    }
    
    LinkListNode *tempNode;
    if (index < (self.size >> 1)) {
        // 在前一半
        tempNode = self.first;
        for (NSInteger i = 0; i < index; i ++) {
            tempNode = tempNode.next;
        }
    } else {
        // 在后一半
        tempNode = self.last;
        for (NSInteger i = self.size - 1; i > index; i --) {
            tempNode = tempNode.prev;
        }
    }
    tempNode.next.prev = tempNode.prev;
    tempNode.prev.next = tempNode.next;
    tempNode.prev = nil;
    tempNode.next = nil;
    self.size --;
}

/// 查看元素的索引
/// @param element element
- (NSInteger)indexOf:(id)element {
    
    LinkListNode *tempNode = self.first;
    for (NSInteger index = 0; index < self.size; index ++) {
        
        if (element == tempNode.element) {
            return index;
        }
        tempNode = tempNode.next;
    }
    return NS_NOT_FOUND;
}

- (NSString *)description {
    
    NSMutableString *string = [NSMutableString string];
    LinkListNode *node = self.first;
    while (node) {
        [string appendFormat:@"%@", node];
        node = node.next;
    }
    return string;
}
@end

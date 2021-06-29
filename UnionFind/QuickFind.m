//
//  QuickFind.m
//  dataStruct
//
//  Created by 张森 on 2021/6/9.
//

#import "QuickFind.h"

@implementation QuickFind

- (NSUInteger)find:(NSUInteger)element {
    [self checkRange:element];
    return [self.parentArray[element] unsignedIntegerValue];
}
- (void)unionElement:(NSUInteger)element to:(NSUInteger)element2 {
    NSUInteger p1 = [self find:element];
    NSUInteger p2 = [self find:element2];
    if (p1 == p2) {
        return;
    }
    for (NSInteger index = 0; index < [self.parentArray count]; index ++) {
        // 每次把element的父节点接到element2的父节点上
        // 最终构造出来的树最多只有两层,因此,查找是O(1),合并是O(n)
        if ([self.parentArray[index] unsignedIntegerValue] == p1) {
            self.parentArray[index] = @(p2);
        }
    }
}

@end

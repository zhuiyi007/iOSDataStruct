//
//  QuickUnion.m
//  dataStruct
//
//  Created by 张森 on 2021/6/9.
//

#import "QuickUnion.h"

@implementation QuickUnion
- (NSUInteger)find:(NSUInteger)element {
    [self checkRange:element];
    // 二分查找,O(logn)
    while (element != [self.parentArray[element] unsignedIntegerValue]) {
        element = [self.parentArray[element] unsignedIntegerValue];
    }
    return element;
}
- (void)unionElement:(NSUInteger)element to:(NSUInteger)element2 {
    // 二分查找,O(logn)
    NSUInteger p1 = [self find:element];
    NSUInteger p2 = [self find:element2];
    if (p1 == p2) {
        return;
    }
    self.parentArray[p1] = @(p2);
}
@end

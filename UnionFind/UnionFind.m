//
//  UnionFind.m
//  dataStruct
//
//  Created by 张森 on 2021/6/9.
//

#import "UnionFind.h"

@implementation UnionFind
- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (self) {
        self.parentArray = [NSMutableArray arrayWithCapacity:capacity];
        for (NSUInteger index = 0; index < capacity; index ++) {
            self.parentArray[index] = @(index);
        }
    }
    return self;
}
- (NSUInteger)find:(NSUInteger)element {
    NSAssert(YES, @"必须在子类中重写该方法!");
    return 0;
}
- (void)unionElement:(NSUInteger)element to:(NSUInteger)element2 {
    NSAssert(YES, @"必须在子类中重写该方法!");
}
- (BOOL)isSame:(NSUInteger)element with:(NSUInteger)element2 {
    
    return [self find:element] == [self find:element2];
}
- (void)checkRange:(NSUInteger)element {
    
    if (element < 0 || element >= [self.parentArray count]) {
        NSAssert(YES, @"数组越界!!");
    }
}
@end

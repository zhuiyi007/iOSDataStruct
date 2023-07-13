//
//  TreeCompartor.m
//  dataStruct
//
//  Created by 张森 on 2021/4/16.
//

#import "TreeCompartor.h"
#import "Person.h"

@implementation TreeCompartor
/// 如果self<node2 返回负数, self>node2 返回正数, 相等返回0
- (NSInteger)compare:(Person *)node1 to:(Person *)node2 {
    
    return node2.age - node1.age;;
}
@end

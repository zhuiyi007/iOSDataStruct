//
//  Person.m
//  dataStruct
//
//  Created by 张森 on 2021/4/16.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithAge:(NSInteger)age {
    
    Person *person = [[Person alloc] init];
    person.age = age;
    return person;;
}

/// 如果self<node2 返回负数, self>node2 返回正数, 相等返回0
- (NSInteger)compareTo:(Person *)node2;
{
    return self.age - node2.age;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%ld", self.age];
}
@end

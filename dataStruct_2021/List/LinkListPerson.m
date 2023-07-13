//
//  LinkListPerson.m
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import "LinkListPerson.h"

@implementation LinkListPerson

+ (instancetype)personWithAge:(NSInteger)age {
    
    LinkListPerson *person = [[LinkListPerson alloc] init];
    person.age = age;
    return person;;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%ld", self.age];
}
@end

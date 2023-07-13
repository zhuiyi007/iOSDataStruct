//
//  LinkListSetRun.m
//  dataStruct
//
//  Created by 张森 on 2021/4/25.
//

#import "LinkListSetRun.h"
#import "LinkListSet.h"
#import "LinkListPerson.h"

@implementation LinkListSetRun

+ (void)run {
    
    LinkListSet *set = [[LinkListSet alloc] init];
    [set add:[LinkListPerson personWithAge:8]];
    [set add:[LinkListPerson personWithAge:9]];
    [set add:[LinkListPerson personWithAge:8]];
    [set add:[LinkListPerson personWithAge:10]];
    [set add:[LinkListPerson personWithAge:9]];
    [set add:[LinkListPerson personWithAge:20]];
    
    
    [set enumElement:^(id _Nonnull node, BOOL * _Nonnull isStop) {
            
        NSLog(@"%@\n", node);
    }];
    
    [set remove:[LinkListPerson personWithAge:20]];
    
    NSLog(@"-----");
    
    [set enumElement:^(id _Nonnull node, BOOL * _Nonnull isStop) {
            
        NSLog(@"%@\n", node);
    }];
}

@end

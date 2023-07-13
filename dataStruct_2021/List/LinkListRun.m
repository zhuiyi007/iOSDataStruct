//
//  LinkListRun.m
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import "LinkListRun.h"
#import "LinkList.h"
#import "LinkListPerson.h"

@implementation LinkListRun
+ (void)run {
    LinkList *list = [[LinkList alloc] init];
    LinkListPerson *person = [LinkListPerson personWithAge:3];
    [list add:[LinkListPerson personWithAge:2]];
    [list add:[LinkListPerson personWithAge:1]];
    [list add:[LinkListPerson personWithAge:5]];
    [list add:[LinkListPerson personWithAge:4]];
    [list add:person];
    [list add:[LinkListPerson personWithAge:8]];
    [list add:[LinkListPerson personWithAge:9]];
    [list add:[LinkListPerson personWithAge:10]];
    [list add:[LinkListPerson personWithAge:20]];
    
    NSLog(@"%@", list);
    
    [list remove:9];
    
    NSLog(@"%@", list);
    
    [list remove:0];
    
    NSLog(@"%@", list);
    
    [list set:5 element:[LinkListPerson personWithAge:555]];
    
    NSLog(@"%@", list);
    
    NSLog(@"%ld", [list indexOf:person]);
    
    NSLog(@"%hhd", [list contains:person]);
}
@end

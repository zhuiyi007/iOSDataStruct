//
//  HeapRun.m
//  dataStruct
//
//  Created by 张森 on 2021/5/26.
//

#import "HeapRun.h"
#import "BinaryHeap.h"
#import "Person.h"
#import "MJBinaryTrees.h"

@implementation HeapRun

+ (void)binaryHeapTest {
    BinaryHeap *heap = [[BinaryHeap alloc] init];
    int arr[8] = {68, 72, 43, 50, 38, 10, 90, 65};
    NSMutableArray *personArr = [NSMutableArray array];
    for (int index = 0; index < 8; index ++) {
        
        Person *person = [Person personWithAge:arr[index]];
        [personArr addObject:person];
        [heap add:person];
    }
    NSLog(@"%@", heap);
    NSLog(@"------");
    [heap replace:[Person personWithAge:70]];
//    [heap remove];
    NSLog(@"%@", heap);
}

+ (void)binaryHeapifyTest {
    
    int arr[14] = {77, 25, 11, 72, 66, 50, 59, 3, 97, 49, 61, 87, 42, 38};
    
    NSMutableArray *personArr = [NSMutableArray array];
    for (int index = 0; index < 14; index ++) {
        
        Person *person = [Person personWithAge:arr[index]];
        [personArr addObject:person];
    }
    BinaryHeap *heap = [BinaryHeap binaryHeap:personArr];
    NSLog(@"%@", heap);
    NSLog(@"------");
}
+ (void)run {
    
    [self binaryHeapifyTest];
}
@end

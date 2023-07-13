//
//  TreeRun.m
//  dataStruct
//
//  Created by 张森 on 2021/4/16.
//

#import "TreeRun.h"
#import "BinarySearchTree.h"
#import "Person.h"
#import "TreeCompartor.h"
#import "MJBinaryTrees.h"
#import "AVLTree.h"
#import "RedBlackTree.h"
@implementation TreeRun

+ (void)binarySearchTreeTest {
//    BinarySearchTree *tree = [BinarySearchTree treeWithCompartor:[[TreeCompartor alloc] init]];
//    [tree add:[Person personWithAge:10]];
//    [tree add:[Person personWithAge:2]];
//    [tree add:[Person personWithAge:34]];
//    [tree add:[Person personWithAge:29]];
//    [tree add:[Person personWithAge:1]];
//    [tree add:[Person personWithAge:8]];
//    [tree add:[Person personWithAge:12]];
    
//    [tree preorderPrint:^(id  _Nonnull node, BOOL * _Nonnull isStop) {
//
//        NSLog(@"%@", node);
//        *isStop = YES;
//    }];
//    NSLog(@"----");
//    [tree inorderPrint:^(id  _Nonnull node, BOOL * _Nonnull isStop) {
//        NSLog(@"%@", node);
//        *isStop = YES;
//    }];
//    NSLog(@"----");
//    [tree postorderPrint:^(id  _Nonnull node, BOOL * _Nonnull isStop) {
//        NSLog(@"%@", node);
//        *isStop = YES;
//    }];
//    NSLog(@"----");
//    [tree levelorderPrint:^(id  _Nonnull node, BOOL * _Nonnull isStop) {
//        NSLog(@"%@", node);
//        *isStop = YES;
//    }];
    
//    NSLog(@"%ld", [tree height]);
    
    
//    BinarySearchTree *completeTree = [BinarySearchTree treeWithCompartor:nil];
//    [completeTree add:[Person personWithAge:20]];
//    [completeTree add:[Person personWithAge:10]];
//    [completeTree add:[Person personWithAge:30]];
//    [completeTree add:[Person personWithAge:5]];
//    [completeTree add:[Person personWithAge:15]];
//    [completeTree add:[Person personWithAge:25]];
//    [completeTree add:[Person personWithAge:35]];
//    [completeTree add:[Person personWithAge:1]];
//    [completeTree add:[Person personWithAge:6]];
//    [completeTree add:[Person personWithAge:13]];
//    [completeTree add:[Person personWithAge:16]];
//    [completeTree add:[Person personWithAge:7]];
//    [completeTree add:[Person personWithAge:0]];
    
//    [completeTree add:[Person personWithAge:7]];
//    [completeTree add:[Person personWithAge:4]];
//    [completeTree add:[Person personWithAge:9]];
//    [completeTree add:[Person personWithAge:2]];
//    [completeTree add:[Person personWithAge:1]];
    
//    [MJBinaryTrees println:completeTree];
//    NSLog(@"---------------");
//    [completeTree remove:[Person personWithAge:10]];
//    [MJBinaryTrees println:completeTree];
    
//    NSLog(@"%hhd", [completeTree isCompleteTree]);
//    [completeTree levelorderPrint:^(id  _Nonnull node, BOOL * _Nonnull isStop) {
//        NSLog(@"%@", node);
//    }];
    
//    [tree levelorderPrint];
    
//    NSArray *arr = @[@(62), @(8), @(97), @(30), @(71), @(14), @(28)];
//    BinarySearchTree *tree1 = [BinarySearchTree treeWithCompartor:nil];
//    for (NSInteger index = 0; index < [arr count]; index ++) {
//        
//        [tree1 add:[Person personWithAge:[arr[index] integerValue]]];
//    }
//    [MJBinaryTrees println:tree1];
//    
//    
//    [tree1 remove:[Person personWithAge:97]];
//    [MJBinaryTrees println:tree1];
//    return;
//    for (NSInteger index = 0; index < [arr count]; index ++) {
//        
//        NSLog(@"\n------%@---------", arr[index]);
//        [tree1 remove:[Person personWithAge:[arr[index] integerValue]]];
//        [MJBinaryTrees println:tree1];
//    }
    
}

+ (void)avlTreeTest {
    
    AVLTree *avlTree = [AVLTree treeWithCompartor:nil];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index ++) {

        NSInteger element = arc4random() % 100;
        NSLog(@"\n------%ld---------", element);
        [array addObject:[Person personWithAge:element]];
        [avlTree add:[Person personWithAge:element]];
        [MJBinaryTrees println:avlTree];
    }
    
    NSLog(@"+++++++++++++++++++++++++");
    [MJBinaryTrees println:avlTree];
    for (NSInteger index = 0; index < [array count]; index ++) {
        
        NSLog(@"\n------%ld---------", [(Person *)array[index] age]);
        [avlTree remove:array[index]];
        [MJBinaryTrees println:avlTree];
    }
}

+ (void)redBlackTreeTest {
//    62, 1, 56, 31, 75, 82, 72, 46, 5, 64, 65, 52, 15, 41, 91, 68
    RedBlackTree *tree = [RedBlackTree treeWithCompartor:nil];
    int arr[16] = {62, 1, 56, 31, 75, 82, 72, 46, 5, 64, 65, 52, 15, 41, 91, 68};
    NSMutableArray *personArr = [NSMutableArray array];
    for (int index = 0; index < 16; index ++) {
        
//        NSLog(@"[%d]", arr[index]);
        Person *person = [Person personWithAge:arr[index]];
        [personArr addObject:person];
        [tree add:person];
    }
    [MJBinaryTrees println:tree];
    NSLog(@"------------------------");
    
    for (int index = 0; index < 16; index ++) {
        
        NSLog(@"[%d]", arr[index]);
        [tree remove:personArr[index]];
        [MJBinaryTrees println:tree];
        NSLog(@"------------------------");
    }
}

+ (void)run {
    
    [self redBlackTreeTest];
}
@end

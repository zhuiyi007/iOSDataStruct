//
//  UnionFind.h
//  dataStruct
//
//  Created by 张森 on 2021/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#warning 缺size优化,rank优化,路径减半,路径压缩
@interface UnionFind : NSObject

/// 存放的是当前位置的父节点
@property (nonatomic, strong) NSMutableArray <NSNumber *>* parentArray;
- (instancetype)initWithCapacity:(NSUInteger)capacity;
/// 查找该元素的父节点
/// @param element element
- (NSUInteger)find:(NSUInteger)element;
/// 合并两个集合,element往element2进行合并
/// @param element element
/// @param element2 element2
- (void)unionElement:(NSUInteger)element to:(NSUInteger)element2;
/// 判断两个元素是否在同一集合内
/// @param element element
/// @param element2 element2
- (BOOL)isSame:(NSUInteger)element with:(NSUInteger)element2;
- (void)checkRange:(NSUInteger)element;
@end

NS_ASSUME_NONNULL_END

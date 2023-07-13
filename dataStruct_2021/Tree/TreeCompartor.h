//
//  TreeCompartor.h
//  dataStruct
//
//  Created by 张森 on 2021/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeCompartor : NSObject

/// 如果self<node2 返回负数, self>node2 返回正数, 相等返回0
- (NSInteger)compare:(id)node1 to:(id)node2;

@end

NS_ASSUME_NONNULL_END

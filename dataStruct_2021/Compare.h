//
//  Compare.h
//  dataStruct
//
//  Created by 张森 on 2021/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Compare <NSObject>
/// 如果self<node2 返回负数, self>node2 返回正数, 相等返回0
- (NSInteger)compareTo:(id<Compare>)node2;
@end

NS_ASSUME_NONNULL_END

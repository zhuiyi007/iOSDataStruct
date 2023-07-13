//
//  Person.h
//  dataStruct
//
//  Created by 张森 on 2021/4/16.
//

#import <Foundation/Foundation.h>
#import "Compare.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<Compare>

@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithAge:(NSInteger)age;
@end

NS_ASSUME_NONNULL_END

//
//  LinkListPerson.h
//  dataStruct
//
//  Created by 张森 on 2021/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkListPerson : NSObject
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithAge:(NSInteger)age;
@end

NS_ASSUME_NONNULL_END

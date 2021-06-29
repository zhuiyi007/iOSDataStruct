//
//  Trie.h
//  dataStruct
//
//  Created by 张森 on 2021/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trie : NSObject

/// 大小
- (NSInteger)size;
/// 是否为空
- (BOOL)isEmpty;
/// 清空
- (void)clear;
/// 是否包含单词
/// @param word word
- (BOOL)contains:(NSString *)word;
/// 添加字符串
/// @param str str
- (void)add:(NSString *)str;
/// 删除字符串
/// @param str str
- (void)remove:(NSString *)str;
/// 是否以此字符开头
/// @param prefix prefix
- (BOOL)startWith:(NSString *)prefix;

@end

NS_ASSUME_NONNULL_END

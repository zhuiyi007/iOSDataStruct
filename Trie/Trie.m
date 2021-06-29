//
//  Trie.m
//  dataStruct
//
//  Created by 张森 on 2021/6/2.
//

#import "Trie.h"

@interface TrieNode : NSObject

@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) BOOL isWord;
@property (nonatomic, strong) NSMutableDictionary <NSString *, TrieNode *>*child;
@property (nonatomic, strong) TrieNode *parent;

@end

@implementation TrieNode

- (NSMutableDictionary<NSString *,TrieNode *> *)child {
    
    if (!_child) {
        _child = [NSMutableDictionary dictionary];
    }
    return _child;
}

@end

@interface Trie ()

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) TrieNode *root;

@end

@implementation Trie

/// 大小
- (NSInteger)size {
    
    return _size;
}
/// 是否为空
- (BOOL)isEmpty {
    
    return self.size == 0;
}
/// 清空
- (void)clear {
    
}
/// 是否包含单词
/// @param word word
- (BOOL)contains:(NSString *)word {

    return [[self _getNode:word] isWord];
}
/// 添加字符串
/// @param str str
- (void)add:(NSString *)str {
    
    TrieNode *node = self.root;
    for (NSInteger index = 0; index < [str length]; index ++) {
        
        NSString *subStr = [str substringWithRange:NSMakeRange(index, 1)];
        if ([node.child[subStr].value isEqualToString:subStr]) {
            // 如果子节点中有当前字符串,继续向下遍历
            node = node.child[subStr];
        } else {
            // 子节点中没有当前字符串
            // 创建子节点
            TrieNode *childNode = [[TrieNode alloc] init];
            // 维护value和parent
            childNode.value = subStr;
            childNode.parent = node;
            // 维护parent的child
            [node.child setValue:childNode forKey:subStr];
            // 继续向下遍历
            node = childNode;
        }
    }
    
    if (!node.isWord) {
        // 原先不存在这个单词,size++
        self.size ++;
        node.isWord = YES;
    }
}
/// 删除字符串
/// @param str str
- (void)remove:(NSString *)str {
    
    TrieNode *node = [self _getNode:str];
    if (!node.isWord) {
        // 不是单词结尾,直接return
        return;
    }
    self.size --;
    if ([node.child count] > 0) {
        node.isWord = NO;
        return;
    }
    
    while (node) {
        
        TrieNode *parentNode = node.parent;
        [parentNode.child removeObjectForKey:node.value];
        if (parentNode.isWord || [parentNode.child count] > 0) {
            // 如果当前节点是另一个词的结尾,或者此时还有另外的单词分支
            // 直接返回
            return;
        }
        node = node.parent;
        node.parent = nil;
    }
}
/// 是否以此字符开头
/// @param prefix prefix
- (BOOL)startWith:(NSString *)prefix {
    
    return [self _getNode:prefix] ? YES : NO;
}

- (TrieNode *)_getNode:(NSString *)str {
    TrieNode *node = self.root;
    for (NSInteger index = 0; index < [str length]; index ++) {
        
        NSString *subString = [str substringWithRange:NSMakeRange(index, 1)];
        if (node.child[subString]) {
            node = node.child[subString];
        } else {
            return nil;
        }
    }
    return node;
}

- (TrieNode *)root {
    if (!_root) {
        _root = [[TrieNode alloc] init];
    }
    return _root;
}

@end

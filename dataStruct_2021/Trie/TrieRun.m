//
//  TrieRun.m
//  dataStruct
//
//  Created by 张森 on 2021/6/2.
//

#import "TrieRun.h"
#import "Trie.h"

@implementation TrieRun

+ (void)run {
    
    Trie *trie = [[Trie alloc] init];
    [trie add:@"cat"];
    [trie add:@"dog"];
    [trie add:@"catalog"];
    [trie add:@"cast"];
    assert([trie size] == 4);
    assert([trie startWith:@"do"]);
    assert([trie startWith:@"c"]);
    assert([trie startWith:@"ca"]);
    assert([trie startWith:@"cat"]);
    assert([trie startWith:@"cata"]);
    assert(![trie startWith:@"hehe"]);
    assert([trie contains:@"cat"]);
    assert([trie contains:@"cast"]);
    assert(![trie contains:@"cata"]);
    [trie remove:@"cat"];
    assert(![trie contains:@"cat"]);
    [trie remove:@"catalog"];
    assert(![trie contains:@"catalog"]);
    [trie remove:@"do"];
    assert([trie contains:@"dog"]);
    assert([trie size] == 2);
}

@end

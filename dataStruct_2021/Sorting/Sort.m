//
//  Sort.m
//  dataStruct
//
//  Created by 张森 on 2021/6/5.
//

#import "Sort.h"
#import "NSNumber+Sorting.h"

@interface Sort ()

@property (nonatomic, assign) NSInteger compareCount;
@property (nonatomic, assign) NSInteger exchangeCount;
@property (nonatomic, assign) NSTimeInterval time;

@end

@implementation Sort
- (void)sort:(NSMutableArray <NSNumber *>*)arr {
    
    if ([arr count] < 2) {
        return;
    }
    self.compareCount = 0;
    self.exchangeCount = 0;
    self.array = [arr mutableCopy];
    
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    [self sort];
    self.time = [[NSDate date] timeIntervalSince1970] - startTime;
    assert([SortingTools isAsce:self.array]);
}

- (void)sort:(NSMutableArray <NSNumber *>*)arr functionClass:(Sort *)functionClass, ...NS_REQUIRES_NIL_TERMINATION {
    
    NSMutableArray <Sort *>*tmpArray = [NSMutableArray array];
    
    [functionClass sort:arr];
    [tmpArray addObject:functionClass];
    
    //1.定义一个指向个数可变的参数列表指针；
    va_list args;
    
    //2.va_start(args, str);string为第一个参数，也就是最右边的已知参数,这里就是获取第一个可选参数的地址.使参数列表指针指向函数参数列表中的第一个可选参数，函数参数列表中参数在内存中的顺序与函数声明时的顺序是一致的。
    va_start(args, functionClass);
    
    if (functionClass)
    {
        //依次取得除第一个参数以外的参数
        //4.va_arg(args,NSString)：返回参数列表中指针所指的参数，返回类型为NSString，并使参数指针指向参数列表中下一个参数。
        Sort *cls;
        while ((cls = va_arg(args, Sort *)))
        {
            [cls sort:arr];
            [tmpArray addObject:cls];
        }
    }
    //5.清空参数列表，并置参数指针args无效。
    va_end(args);
    
    
    for (NSInteger end = [tmpArray count]; end > 0; end --) {
        for (NSInteger index = 1; index < end; index ++) {
            if (tmpArray[index].time < tmpArray[index - 1].time) {
                Sort *tmp = tmpArray[index];
                tmpArray[index] = tmpArray[index - 1];
                tmpArray[index - 1] = tmp;
            }
        }
    }
    for (Sort *sort in tmpArray) {
        NSLog(@"%@", sort);
    }
    
}

- (void)sort {
    
    NSAssert(NO, @"子类必须重写此方法");
}

/// 交换两个位置的元素
/// @param index index
/// @param toIndex toIndex
- (void)exchange:(NSUInteger)index to:(NSUInteger)toIndex {
    
    assert(!(index < 0 || index >= [self.array count] ||
            toIndex < 0 || toIndex >= [self.array count]));
    
    NSNumber *tmp = self.array[index];
    self.array[index] = self.array[toIndex];
    self.array[toIndex] = tmp;
    self.exchangeCount ++;
}

/// 比较两个位置的元素
/// return < 0 array[index] < array[toIndex]
/// return = 0 array[index] = array[toIndex]
/// return > 0 array[index] > array[toIndex]
/// @param index index
/// @param toIndex toIndex
- (NSInteger)compare:(NSUInteger)index to:(NSUInteger)toIndex {
    
    assert(!(index < 0 || index >= [self.array count] ||
            toIndex < 0 || toIndex >= [self.array count]));
    self.compareCount ++;
    return [self.array[index] integerValue] - [self.array[toIndex] integerValue];
}

/// 比较两个元素
/// return < 0 element < element2
/// return = 0 element = element2
/// return > 0 element > element2
/// @param element element
/// @param element2 element2
- (NSInteger)compareElement:(NSNumber *)element to:(NSNumber *)element2 {
    
    self.compareCount ++;
    return [element integerValue] - [element2 integerValue];
}

- (NSString *)_formatCount:(NSUInteger)count {
    
    if (count < 10000) {
        return [NSString stringWithFormat:@"%lu", (unsigned long)count];
    } else if (count < 1000000) {
        return [NSString stringWithFormat:@"%.2f 万", count / 10000.0f];
    } else if (count < 10000000) {
        return [NSString stringWithFormat:@"%.2f 百万", count / 1000000.0f];
    } else if (count < 100000000) {
        return [NSString stringWithFormat:@"%.2f 千万", count / 10000000.0f];
    } else {
        return [NSString stringWithFormat:@"%.2f 亿", count / 100000000.0f];
    }
}

- (BOOL)_isStable {
    
//    NSMutableArray <NSNumber *>*tmpArray = [NSMutableArray array];
//    void * a[10];
//    for (NSInteger i = 0; i < 10; i++) {
//
//        NSNumber *number = [[NSNumber alloc] initWithLong:@0xfffffffffffff11];
//        [tmpArray addObject:number];
//        a[i] = &number;
//    }
//    [self sort:tmpArray];
//
//    for (NSInteger i = 0; i < 10; i++) {
//
//        NSNumber *number = tmpArray[i];
//        if (a[i] != &number) {
//            return NO;
//        }
//    }
    return YES;
}

- (NSString *)description {
    
    NSString *str = [NSString stringWithFormat:@"%s\n耗时:%.0f s (%.2f ms)\n比较次数:%@\n交换次数:%@\n---------------\n", object_getClassName(self), self.time, self.time * 1000, [self _formatCount:self.compareCount], [self _formatCount:self.exchangeCount]];
    return str;
}
@end

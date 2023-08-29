//
//  ListInterface.swift
//  dataStruct_2023
//
//  Created by firstzhang on 2023/7/14.
//
//  链表的接口
/*
int size (); 1/元素的数量
boolean isEmpty()；1/是否为空
boolean contains(E element);1/是否包含某个元素
void add (E element);1/添加元素到最后面
E get (int index);1/返回index位置对应的元素
E set(int index, E element);1/设置index位置的元素
void add(int index， E element)； 1/往index位置添加元素
E remove (int index);1删除index位置对应的元素
int indexof(E element)；/1查看元素的位置
void clear ();清除所有元素
 */

import Foundation

protocol ListInterface {
    associatedtype E
    var NS_NOT_FOUND: Int {get}
    /// 返回列表中元素的个数
    func size() -> Int
    /// 列表是否为空
    func isEmpty() -> Bool
    /// 列表中是否包含某个元素
    func contains(element: E) -> Bool
    /// 添加元素
    func add(element: E)
    /// 往index位置添加元素
    func add(index: Int, element: E)
    /// 获取某个位置的元素
    func get(index: Int) -> E?
    /// 替换index位置的元素
    /// - Returns: 返回原位置的元素
    func set(index: Int, element: E) -> E?
    /// 移除index位置的元素
    /// - Returns: 返回原位置的元素
    func remove(index: Int) -> E?
    /// 返回某个元素的位置
    func indexOf<E: Equatable>(element: E) -> Int
    /// 清除所有元素
    func clear()
}

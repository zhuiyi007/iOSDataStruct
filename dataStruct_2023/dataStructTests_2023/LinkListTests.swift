//
//  LinkListTests.swift
//  dataStructTests_2023
//
//  Created by firstzhang on 2023/7/14.
//

import XCTest

final class LinkListTests: XCTestCase {
    func testLinkList() throws {
        let linkList: LinkList = LinkList<Int>()
        linkListHelper(linkList: linkList)
    }
    
    func testDoublyLinkList() throws {
        let linkList: DoublyLinkList = DoublyLinkList<Int>()
        linkListHelper(linkList: linkList)
    }
    
    func testLoopLinkList() throws {
        let linkList: LoopLinkList = LoopLinkList<Int>()
        linkListHelper(linkList: linkList)
    }
    
    func testLoopDoublyLinkList() throws {
        let linkList: LoopDoublyLinkList = LoopDoublyLinkList<Int>()
        linkListHelper(linkList: linkList)
    }
    
    func testJosephus() throws {
        // 测试约瑟夫环
        let linkList: LoopDoublyLinkList = LoopDoublyLinkList<Int>()
        for i in 1..<9 {
            linkList.add(element: i)
        }
        linkList.reset()
        var lastNum: Int = 0
        while linkList.size() > 0 {
            for _ in 0..<2 {
                linkList.goNext()
            }
            lastNum =  linkList.deleteCurrent()!
            print(lastNum)
        }
        XCTAssertEqual(lastNum, 7)
    }
    
    func linkListHelper(linkList: List<Int>) {
        XCTAssertEqual(linkList.size(), 0)
        linkList.add(element: 2)
        linkList.add(element: 3)
        linkList.add(element: 4)
        linkList.add(index: 0, element: 1)
        linkList.add(index: 4, element: 5)
        print(linkList);
        XCTAssertTrue(linkList.contains(element: 1))
        XCTAssertFalse(linkList.contains(element: 6))
        XCTAssertEqual(linkList.size(), 5)
        XCTAssertEqual(linkList.get(index: 0), 1)
        XCTAssertEqual(linkList.get(index: 4), 5)
        XCTAssertEqual(linkList.set(index: 0, element: 6), 1)
        XCTAssertEqual(linkList.set(index: 4, element: 7), 5)
        XCTAssertEqual(linkList.get(index: 0), 6)
        XCTAssertEqual(linkList.get(index: 4), 7)
        XCTAssertEqual(linkList.remove(index: 0), 6)
        XCTAssertEqual(linkList.remove(index: 3), 7)
        XCTAssertEqual(linkList.get(index: 0), 2)
        XCTAssertEqual(linkList.get(index: 2), 4)
        XCTAssertNil(linkList.get(index: 5))
        linkList.clear()
        XCTAssertNil(linkList.get(index: 0))
        XCTAssertNil(linkList.remove(index: 0))
    }
}

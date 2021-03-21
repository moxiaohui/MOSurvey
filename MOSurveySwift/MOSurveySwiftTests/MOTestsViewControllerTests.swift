//
//  MOTestsViewControllerTests.swift
//  MOSurveySwiftTests
//
//  Created by MikiMo on 2021/3/20.
//

import XCTest
@testable import MOSurveySwift
// https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/01-introduction.html#//apple_ref/doc/uid/TP40014132-CH1-SW1

// Swift 无法测试私有属性和方法
// Note: @testable provides access only for internal functions; file-private and private declarations are not visible outside of their usual scope when using @testable.
// https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/04-writing_tests.html
// OC 的可以用分类在这里，再次声明一下就可以测试了

class MOTestsViewControllerTests: XCTestCase {

    private var vc: MOTestsViewController = {
        let vc = MOTestsViewController()
        return vc
    }()
    
    override class func setUp() {
        print("mo: class setUp")
    }
    
    override class func tearDown() {
        print("mo: class tearDown")
    }

    override func setUp() {
        print("mo: setUp")
    }
    
    override func setUpWithError() throws {
        self.vc = MOTestsViewController()
        print("mo: setUpWithError")

    }
    
    override func tearDownWithError() throws {
        print("mo: tearDownWithError")
    }
    
    override func tearDown() {
        print("mo: tearDown")
    }

    func testSubscribeButton() throws {
        print("mo: testFuncation1")
        // 断言为不为nil (XCTAssertNil 断言为nil)
        XCTAssertNotNil(self.vc.subscribeButton)
        // 断言为NO
        XCTAssertFalse(self.vc.subscribeButton.isSelected)
        self.vc.clickSubscribeButton(sender: self.vc.subscribeButton)
        // 断言为YES
        XCTAssert(self.vc.subscribeButton.isSelected)
        // 断言为YES
        XCTAssertTrue(self.vc.subscribeButton.isSelected)
        // 断言 两个对象 相等 (XCTAssertEqualObjects 断言多个对象相等)
        XCTAssertEqual(self.vc.subscribeButton, self.vc.subscribeButton);
        
//        XCTFail("自己创建Tests报错");
        // 断言不会抛出异常
//        XCTAssertNoThrow(<#T##expression: T##T#>)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            print("mo: testFuncation2")
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  MOHeaderAvatarViewTests.m
//  MOSurveyOCUITests
//
//  Created by MikiMo on 2021/3/11.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MOHeaderAvatarView.h"

@interface MOHeaderAvatarView (Private)

@property (nonatomic, strong) UIButton *subscribeButton;    // 主账号订阅按钮

- (void)clickSubscribeButton;

@end

@interface MOHeaderAvatarHostView : XCTestCase <MOHeaderAvatarViewDelegate>

@property (nonatomic, strong) MOHeaderAvatarView *headerView;
@property (nonatomic, assign) BOOL shouldSetValue;

@end

@implementation MOHeaderAvatarHostView

- (void)clickSubscribeButton {
    self.headerView.subscribed = _shouldSetValue;
}

@end


@interface MOHeaderAvatarViewTests : XCTestCase

@property (nonatomic, strong) MOHeaderAvatarHostView *hostView;
//@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation MOHeaderAvatarViewTests

- (void)setUp {
//    self.app = [[XCUIApplication alloc] init];
//    [self.app launch];
    
    self.hostView = [[MOHeaderAvatarHostView alloc] init];
    self.hostView.headerView = [[MOHeaderAvatarView alloc] init];
    self.hostView.headerView.delegate = self.hostView;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

//- (void)testSubscribeAction2 {
    // 测试点击未订阅按钮，订阅后按钮显示状态
//    id mockHeaderView = OCMClassMock([MOHeaderAvatarView class]);
//    XCUIElement *button = [[XCUIApplication alloc] init].buttons[@"subscribeButton"];
//    XCTAssertTrue(button, @"subscribeButton 存在");
//    [button tap];
//    OCMVerify([mockHeaderView clickSubscribeButton]);
//    self.app.otherElements.
//    [[[XCUIApplication alloc] init].buttons[@"\u8ba2\u9605"] tap];
//    [[[XCUIApplication alloc] init]/*@START_MENU_TOKEN@*/.staticTexts[@"\U8ba2\U9605"]/*[[".buttons[@\"\\U8ba2\\U9605\"].staticTexts[@\"\\U8ba2\\U9605\"]",".staticTexts[@\"\\U8ba2\\U9605\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
//}

- (void)testSubscribeAction {
    // 测试点击未订阅按钮，订阅后按钮显示状态
    UIButton *subscribeButton = self.hostView.headerView.subscribeButton;
    self.hostView.headerView.subscribed = NO;
    self.hostView.shouldSetValue = YES;
//    XCTAssertNil(subscribeButton.imageView.image);
//    XCTAssertEqual(subscribeButton.titleLabel.text, @"订阅");
    XCTAssertFalse(subscribeButton.selected);
    [self.hostView.headerView clickSubscribeButton];
    
//    XCTAssertEqual(subscribeButton.imageView.image, [UIImage imageNamed:@"mo_check"]);
    XCTAssertTrue(subscribeButton.selected);
}
 
- (void)testUnsubscribeAction {
    // 测试点击订阅按钮，取消订阅后按钮显示状态
    self.hostView.headerView.delegate = self.hostView;
    UIButton *subscribeButton = self.hostView.headerView.subscribeButton;
    self.hostView.headerView.subscribed = YES;
    self.hostView.shouldSetValue = NO;
    XCTAssertTrue(subscribeButton.selected);
//    XCTAssertEqual(subscribeButton.imageView.image, [UIImage imageNamed:@"mo_check"]);
//    XCTAssertNil(subscribeButton.titleLabel.text);
    [self.hostView.headerView clickSubscribeButton];
//    XCTAssertNil(subscribeButton.imageView.image);
    XCTAssertFalse(subscribeButton.selected);
}


@end

//
//  MOSurveyOCTests.m
//  MOSurveyOCTests
//
//  Created by 莫小言 on 2021/4/11.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "MOPerson.h"
#import "MOTitleLineView.h"

@interface MOSurveyOCTests : XCTestCase

@end

@implementation MOSurveyOCTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMockObjects {
    // 1、Creating mock objects 创建模拟对象
    // 1.1、Class mocks 模拟实例
    // 根据类，模拟其实例
    id classMock = OCMClassMock([MOPerson class]);
    
    // 1.2、Protocol mocks 模拟代理
    // 根据协议名，模拟已经实现协议的实例
    id protocolMock = OCMProtocolMock(@protocol(MOTitleLineViewDelegate));
    
    // 1.3、Strict class and protocol mocks 精准模拟
    // 在接受到不显式预期的方法时引发异常
    id strictClassMock = OCMStrictClassMock([MOPerson class]);
    id strictProtocolMock = OCMStrictProtocolMock(@protocol(MOTitleLineViewDelegate));
    
    // 1.4、Partial mocks 局部模拟
    // 已经stub的方法会返回stub的值；未stub的方法会转发给 模拟的对象(aPerson)
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMock = OCMPartialMock(aPerson);
    
}

- (void)testStubMethods {
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMock = OCMPartialMock(aPerson);

    // 2、Stubbing methods 模拟方法
    // 2.1、模拟方法的返回值
    OCMStub([partialMock name]).andReturn(@"moxiaoyan");
    
    // 2.2、委托给另一个方法
    MOPerson *anotherPerson = [[MOPerson alloc] init];
    // 另一个对象的方法，方法签名需要一致
    OCMStub([partialMock name]).andCall(anotherPerson, @selector(name));

    // 2.3、委托给一个block
    OCMStub([partialMock name]).andDo(^(NSInvocation *invocation){
        // 调用name方法时，将会调用这个block
        // invocation会携带方法参数
        // invocation可以设置返回值
    });
    // OCMStub([partialMock name]).andDo(nil);
    
    // 2.5、模拟 通过参数返回值的方法 的返回值
    // 2.5.1、对象参数
    NSError *error = [NSError errorWithDomain:@"获取friends失败(stubbed)" code:001 userInfo:nil];
    OCMStub([partialMock loadFriendsWithError:[OCMArg setTo:error]]);
    
    NSError *resultError = nil;
    [partialMock loadFriendsWithError:&resultError];
    NSLog(@"%@", resultError);
    
    // 2.5.2、非对象参数
    // OCMStub([mock someMethodWithReferenceArgument:[OCMArg setToValue:OCMOCK_VALUE((int){aValue})]]);

    // 2.6、模拟block参数
    OCMStub([partialMock deviceWithComplete:[OCMArg invokeBlock]]);
    [partialMock deviceWithComplete:^(NSString * _Nonnull value) {
        NSLog(@"%@", value); // nil
    }];
    OCMStub([partialMock deviceWithComplete:[OCMArg invokeBlockWithArgs:@"iPhone"]]);
    [partialMock deviceWithComplete:^(NSString * _Nonnull value) {
        NSLog(@"%@", value); // iPhone
    }];

    // 2.7、抛出异常
    NSException *exception = [[NSException alloc] initWithName:@"获取name异常" reason:@"name为空" userInfo:nil];
    OCMStub([partialMock name]).andThrow(exception);
    
    // 2.8、发出通知
    NSNotification *notify = [NSNotification notificationWithName:@"通知" object:self userInfo:nil];
    OCMStub([partialMock name]).andPost(notify);
    
    // 2.9、链接模拟方法
    // OCMStub([mock someMethod]).andPost(aNotification).andReturn(aValue);

    // 2.10、转发给真正的对象/类
    OCMStub([partialMock name]).andForwardToRealObject();

    // 2.11、实现XCTest的预期
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"XCTest的期望"];
    OCMStub([partialMock name]).andFulfill(expectation);
    
    // 2.12、打印log (可以在链中使用)
    OCMStub([partialMock name]).andLog(@"%@", @"hehe");
    
    // 2.13、打开调试，断点会生效
    OCMStub([partialMock name]).andBreak();
}

- (void)testVerifyingInteractions {
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMock = OCMPartialMock(aPerson);

    // Verifying interactions 验证相关作用
    // 3.1、验证方法已调用
    [aPerson name];
    OCMVerify([partialMock name]);
    
    // 3.2、验证Stubbed的方法被调用
    OCMStub([partialMock name]).andReturn(@"momo");
    [aPerson name];
    OCMVerify([partialMock name]);

    // 3.3、Quantifiers requires 量词要求
    OCMVerify(atLeast(2), [partialMock name]);
    // OCMVerify(never(),    [partialMock doStuff]);
    // OCMVerify(times(0),   [partialMock doStuff]);
    // OCMVerify(times(n),   [partialMock doStuff]);
    // OCMVerify(atLeast(n), [partialMock doStuff]);
    // OCMVerify(atMost(n),  [partialMock doStuff]);
}


@end

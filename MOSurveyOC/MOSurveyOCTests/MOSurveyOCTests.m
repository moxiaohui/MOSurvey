//
//  MOSurveyOCTests.m
//  MOSurveyOCTests
//
//  Created by 莫小言 on 2021/4/11.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <OCHamcrest/OCHamcrest.h>

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
    id mockPerson = OCMClassMock([MOPerson class]);
    
    // 1.2、Protocol mocks 模拟代理
    // 根据协议名，模拟已经实现协议的实例
    id mockProtocol = OCMProtocolMock(@protocol(MOTitleLineViewDelegate));
    
    // 1.3、Strict class and protocol mocks 精准模拟
    // 在接受到不显式预期的方法时引发异常
    id strictMockClass = OCMStrictClassMock([MOPerson class]);
    id strictMockProtocol = OCMStrictProtocolMock(@protocol(MOTitleLineViewDelegate));
    
    // 1.4、Partial mocks 局部模拟
    // 已经stub的方法会返回stub的值；未stub的方法会转发给 模拟的对象(aPerson)
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMockPerson = OCMPartialMock(aPerson);
    
}

- (void)testStubMethods {
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMockPerson = OCMPartialMock(aPerson);

    // 2、Stubbing methods 模拟方法
    // 2.1、模拟方法的返回值
    OCMStub([partialMockPerson name]).andReturn(@"moxiaoyan");
    
    // 2.2、委托给另一个方法
    MOPerson *anotherPerson = [[MOPerson alloc] init];
    // 另一个对象的方法，方法签名需要一致
    OCMStub([partialMockPerson name]).andCall(anotherPerson, @selector(name));

    // 2.3、委托给一个block
    OCMStub([partialMockPerson name]).andDo(^(NSInvocation *invocation){
        // 调用name方法时，将会调用这个block
        // invocation会携带方法参数
        // invocation可以设置返回值
    });
    // OCMStub([partialMock name]).andDo(nil);
    
    // 2.5、模拟 通过参数返回值的方法 的返回值
    // 2.5.1、对象参数
    NSError *error = [NSError errorWithDomain:@"获取friends失败(stubbed)" code:001 userInfo:nil];
    OCMStub([partialMockPerson loadFriendsWithError:[OCMArg setTo:error]]);
    
    NSError *resultError = nil;
    [partialMockPerson loadFriendsWithError:&resultError];
    NSLog(@"%@", resultError);
    
    // 2.5.2、非对象参数
    // OCMStub([mock someMethodWithReferenceArgument:[OCMArg setToValue:OCMOCK_VALUE((int){aValue})]]);

    // 2.6、模拟block参数
    OCMStub([partialMockPerson deviceWithComplete:[OCMArg invokeBlock]]);
    [partialMockPerson deviceWithComplete:^(NSString * _Nonnull value) {
        NSLog(@"%@", value); // nil
    }];
    OCMStub([partialMockPerson deviceWithComplete:[OCMArg invokeBlockWithArgs:@"iPhone"]]);
    [partialMockPerson deviceWithComplete:^(NSString * _Nonnull value) {
        NSLog(@"%@", value); // iPhone
    }];

    // 2.7、抛出异常
    NSException *exception = [[NSException alloc] initWithName:@"获取name异常" reason:@"name为空" userInfo:nil];
    OCMStub([partialMockPerson name]).andThrow(exception);
    
    // 2.8、发出通知
    NSNotification *notify = [NSNotification notificationWithName:@"通知" object:self userInfo:nil];
    OCMStub([partialMockPerson name]).andPost(notify);
    
    // 2.9、链接模拟方法
    // OCMStub([mock someMethod]).andPost(aNotification).andReturn(aValue);

    // 2.10、转发给真正的对象/类
    OCMStub([partialMockPerson name]).andForwardToRealObject();

    // 2.11、实现XCTest的预期
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"XCTest的期望"];
    OCMStub([partialMockPerson name]).andFulfill(expectation);
    
    // 2.12、打印log (可以在链中使用)
    OCMStub([partialMockPerson name]).andLog(@"%@", @"hehe");
    
    // 2.13、打开调试，断点会生效
    OCMStub([partialMockPerson name]).andBreak();
}

- (void)testVerifyingInteractions {
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMockPerson = OCMPartialMock(aPerson);

    // Verifying interactions 验证相关作用
    // 3.1、验证方法已调用
    [aPerson name];
    OCMVerify([partialMockPerson name]);
    
    // 3.2、验证Stubbed的方法被调用
    OCMStub([partialMockPerson name]).andReturn(@"momo");
    [aPerson name];
    OCMVerify([partialMockPerson name]);

    // 3.3、Quantifiers requires 量词要求
    OCMVerify(atLeast(2), [partialMockPerson name]);
    // OCMVerify(never(),    [partialMock doStuff]);
    // OCMVerify(times(0),   [partialMock doStuff]);
    // OCMVerify(times(n),   [partialMock doStuff]);
    // OCMVerify(atLeast(n), [partialMock doStuff]);
    // OCMVerify(atMost(n),  [partialMock doStuff]);
}

- (void)testArgumentConstraints {
    MOPerson *aPerson = [[MOPerson alloc] init];
    id partialMockPerson = OCMPartialMock(aPerson);
    
    // 4、Argument constraints 参数约束
    // Stub：存根，意思是声明这样的一个方法，这样的方法可以被调用
    
    // 4.1、any约束
    // stub方法，可以响应任何调用
    OCMStub([partialMockPerson addChilden:[OCMArg any]]); // 参数是任何对象
    OCMStub([partialMockPerson takeMoney:[OCMArg anyPointer]]); // 参数是任何指针
    OCMStub([partialMockPerson changeWithSelector:[OCMArg anySelector]]); // 参数是任何选择子

    // 4.2、忽视没有对象参数
    // stub方法，可以响应`非对象`参数的调用（可以响应参数没有通过的调用：无论是对象参数or非对象参数）
    OCMStub([partialMockPerson setAge:0]).ignoringNonObjectArgs();

    // 4.3、匹配参数
    // stub方法，仅响应`匹配的参数`的调用
    MOPerson *bPerson = [[MOPerson alloc] init];
    OCMStub([partialMockPerson addChilden:bPerson]);
    OCMStub([partialMockPerson addChilden:[OCMArg isNil]]);
    OCMStub([partialMockPerson addChilden:[OCMArg isNotNil]]);
    OCMStub([partialMockPerson addChilden:[OCMArg isNotEqual:bPerson]]);
    OCMStub([partialMockPerson addChilden:[OCMArg isKindOfClass:[MOPerson class]]]);
    
    // 会触发 anObject 的 aSelector 方法，并将参数传入
    // 在该方法中判断参数是否通过，通过就：返回YES， 否则：返回NO
    id anObject = nil;
    SEL aSelector = @selector(addChilden:);
    OCMStub([partialMockPerson addChilden:[OCMArg checkWithSelector:aSelector onObject:anObject]]);
    
    OCMStub([partialMockPerson addChilden:[OCMArg checkWithBlock:^BOOL(id value) {
        // 判断参数是否通过，通过就：返回YES， 否则：返回NO
        return YES;
    }]]);
    
    // 4.5、使用Hamcrest匹配 (另一个库，之后有空介绍一下)
    OCMStub([partialMockPerson addChilden:startsWith(@"foo")]);
    
}

- (void)testClassMethods {
    // 5、Mocking class methods 模拟类方法
    
    // 5.1、Stub类方法
    id mockPerson = OCMClassMock([MOPerson class]);
    OCMStub([mockPerson mo_className]).andReturn(@"XXMOPerson");
    // (1)此时如果没有同名的实例方法，mo_className类方法是可以被正确Stub的
    NSString *className1 = [MOPerson mo_className]; // XXMOPerson
    // (2)但是如果实例方法有跟之同名时：
    NSString *instanceName = [mockPerson mo_className]; // XXMOPerson
    NSString *className2 = [MOPerson mo_className]; // class MOPerson
    // 则需要用一下方法进行Stub
    OCMStub(ClassMethod([mockPerson mo_className])).andReturn(@"MOMOPerson");
    NSString *className3 = [MOPerson mo_className]; // XXMOPerson
    
    // 5.2、验证类方法已执行
    [mockPerson mo_className];
    OCMVerify([mockPerson mo_className]);
    
    // 5.3、恢复类
    [mockPerson stopMocking];
}

- (void)testPartialMocks {
    // 6、Pattial mocks 部分模拟
    
    MOPerson *aPerson = [[MOPerson alloc] init];
    // 6.1、Stub类方法
    id partialMockPerson = OCMPartialMock(aPerson);
    OCMStub([partialMockPerson mo_className]).andReturn(@"Partail Class");
    NSString *partialName = [partialMockPerson mo_className]; // Partail Class
    NSString *personName = [aPerson mo_className]; // Partail Class
    NSLog(@"%@ %@", partialName, personName);
    
    // 6.2、验证调用
    [partialMockPerson mo_className];
    OCMVerify([partialMockPerson mo_className]);
    
    // 6.3、恢复对象
    [partialMockPerson stopMocking];
}

- (void)testStrictMocks {
    // 7、Strict mocks and expectations 严格的模拟和期望
    
    // 7.1、设置期望-运行-验证
    id mockPerson = OCMClassMock([MOPerson class]);
    OCMExpect([mockPerson addChilden:[OCMArg isNotNil]]);
    [mockPerson addChilden:[MOPerson new]]; // 只要有依次不为nil，就通过了验证！？
    [mockPerson addChilden:nil];
    OCMVerifyAll(mockPerson);
    
    // 7.2、严格的模拟和快速失败
    id strictPerson = OCMStrictClassMock([MOPerson class]);
    // [strictPerson mo_className]; // 没有期望该方法的调用，所以会测试失败

    // 7.3、Stub动作和期望
    OCMExpect([strictPerson mo_className]).andReturn(@"instance_MOPerson");
    // OCMExpect([strictPerson mo_className]).andThrow([NSException ...]);
    [strictPerson mo_className];
    OCMVerifyAll(strictPerson);
    
    // 7.4、延迟验证
    OCMExpect([strictPerson mo_className]);
    [strictPerson mo_className];
    OCMVerifyAllWithDelay(strictPerson, 3.0); // NSTimeInterval
    
    // 7.5、按顺序验证
    [strictPerson setExpectationOrderMatters:YES];
    OCMExpect([strictPerson mo_className]);
    OCMExpect([strictPerson addChilden:[OCMArg any]]);
    // 调用顺序错了，测试就会失败
    [strictPerson mo_className];
    [strictPerson addChilden:nil];
}



@end

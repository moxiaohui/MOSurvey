//
//  MOPerson.h
//  00.OCDemo
//
//  Created by 莫小言 on 2020/8/25.
//  Copyright © 2020 moxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <MOPerson *>*childens;

// 非对象类型 set:nil 会触发 `setNilValueForKey:`
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, strong) NSNumber *age;

+ (instancetype)personWithName:(NSString *)name;

/*  以下，OCMock Demo 使用 */
- (void)loadFriendsWithError:(NSError **)error;
- (void)deviceWithComplete:(void(^)(NSString *value))complete;

@end

NS_ASSUME_NONNULL_END

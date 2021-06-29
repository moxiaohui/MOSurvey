//
//  MOPerson+Tests.h
//  MOSurveyOC
//
//  Created by MikiMo on 2021/6/29.
//

#import "MOPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOPerson (Tests)

/*  以下，OCMock Demo 使用 */
- (void)loadFriendsWithError:(NSError **)error;
- (void)deviceWithComplete:(void(^)(NSString *value))complete;
- (void)addChilden:(MOPerson * _Nullable)person;
- (BOOL)takeMoney:(NSUInteger *)money;
- (void)changeWithSelector:(SEL)selector;
- (NSString *)mo_className;
+ (NSString *)mo_className;

@end

NS_ASSUME_NONNULL_END

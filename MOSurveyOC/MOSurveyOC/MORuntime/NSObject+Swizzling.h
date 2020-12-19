//
//  NSObject+Swizzling.h
//  04.Runtime
//
//  Created by 莫晓卉 on 2020/2/23.
//  Copyright © 2020 moxiaoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END

//
//  NSTimer+MOBlock.h
//  00.OCDemo
//
//  Created by 莫晓卉 on 2020/7/11.
//  Copyright © 2020 moxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (MOBlock)

+ (NSTimer *)mo_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void(^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END

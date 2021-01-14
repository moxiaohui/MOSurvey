//
//  MOProxy.m
//  MOSurveyOC
//
//  Created by 莫晓卉 on 2021/1/14.
//

#import "MOProxy.h"

@implementation MOProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
  return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
  [invocation invokeWithTarget:self.target];
}

@end

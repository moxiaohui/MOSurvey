//
//  NSObject+property.m
//  1、替换方法
//
//  Created by 莫晓卉 on 2018/3/29.
//  Copyright © 2018年 莫晓卉. All rights reserved.
//

#import "NSObject+property.h"
#import <objc/runtime.h>

@implementation NSObject (property)

- (void)setName:(NSString *)name {
  // objc_setAssociatedObject 将某个值 赋值给某个对象的某个属性
  objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
  return objc_getAssociatedObject(self, @"name");
}


@end

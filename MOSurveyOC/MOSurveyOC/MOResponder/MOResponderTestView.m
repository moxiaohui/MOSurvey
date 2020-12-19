//
//  MOResponderTestView.m
//  01.OCTest
//
//  Created by moxiaoyan on 2020/4/9.
//  Copyright © 2020 moxiaoyan. All rights reserved.
//

#import "MOResponderTestView.h"

@interface MOView1 : UIView
@end
@implementation MOView1
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  NSLog(@"view1");
  return [super hitTest:point withEvent:event];
}
@end

@interface MOView2 : UIView
@end
@implementation MOView2
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  NSLog(@"view2");
  return [super hitTest:point withEvent:event];
}
@end

@interface MOView3 : UIView
@end
@implementation MOView3
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  NSLog(@"view3");
  return [super hitTest:point withEvent:event];
}
@end

@interface MOView4 : UIView
@end
@implementation MOView4
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  NSLog(@"view4");
  return [super hitTest:point withEvent:event];
}
@end

@implementation MOResponderTestView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
    MOView1 *view1 = [[MOView1 alloc] initWithFrame:CGRectMake(20, 20, 160, 90)];
    view1.backgroundColor = [UIColor cyanColor];
    [self addSubview:view1];
    MOView2 *view2 = [[MOView2 alloc] initWithFrame:CGRectMake(30, 30, 60, 40)];
    view2.backgroundColor = [UIColor redColor];
    [view1 addSubview:view2];
    
    
    MOView3 *view3 = [[MOView3 alloc] initWithFrame:CGRectMake(20, 120, 60, 60)];
    view3.backgroundColor = [UIColor yellowColor];
    [self addSubview:view3];
    MOView4 *view4 = [[MOView4 alloc] initWithFrame:CGRectMake(100, 120, 60, 60)];
    view4.backgroundColor = [UIColor greenColor];
    [self addSubview:view4];
  }
  return self;
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  NSLog(@"view");
  // 1、控件不允许与用户交互
  if (self.userInteractionEnabled == NO ||
      self.alpha <= 0.01 ||
      self.hidden == YES) {
    return nil;
  }
  // 2、点击的point不在当前控件内
  if (![self pointInside:point withEvent:event]) {
    return nil;
  }
  // 3、往后遍历每一个子控件
  for (int i = (int)self.subviews.count - 1; i >= 0; i--) {
    UIView *childView = self.subviews[i];
    // 当前触控Point的坐标转换为相对于子控件的坐标
    CGPoint childPoint = [self convertPoint:point toView:childView];
    // 在子控件中找能响应的子控件(递归循环)，从上层找起
    UIView *fitView = [childView hitTest:childPoint withEvent:event];
    if (fitView) {
      return fitView;
    }
  }
  // 4、子视图中没有能响应的view，就返回自己
  return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
  BOOL value = (CGRectContainsPoint(frame, point));
  NSArray *views = [self subviews];
  for (UIView *subview in views) {
    value = (CGRectContainsPoint(subview.frame, point));
    if (value) {
      return value;
    }
  }
  return NO;
}

@end

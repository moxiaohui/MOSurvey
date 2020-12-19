//
//  MOResponderViewController.m
//  MOSurveyOC
//
//  Created by 莫晓卉 on 2020/12/18.
//

#import "MOResponderViewController.h"
#import "UIButton+Extension.h"
#import "MOResponderTestView.h"

@interface MOResponderViewController ()

@end

@implementation MOResponderViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self setupView];
}

- (void)setupView {
  // 响应者
  MOResponderTestView *view = [[MOResponderTestView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
  view.backgroundColor = [UIColor grayColor];
  [self.view addSubview:view];
  
  // 将btn绘制成六边形，并将可点区域也设置为六边形
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.drawHexagon = YES; // 是否绘制六边形
  btn.frame = CGRectMake(100, 300, 100, 100);
  [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
  btn.backgroundColor = [UIColor redColor];
  [self.view addSubview:btn];
}

- (void)click {
  NSLog(@"click");
}

@end

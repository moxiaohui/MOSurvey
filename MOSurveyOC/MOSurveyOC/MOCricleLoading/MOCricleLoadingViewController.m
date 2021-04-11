//
//  MOCricleLoadingViewController.m
//  MOSurveyOC
//
//  Created by 莫小言 on 2020/12/18.
//

#import "MOCricleLoadingViewController.h"
#import "MOCircleLoadingView.h"
#import "MOSurveyOC-Swift.h"

@interface MOCricleLoadingViewController ()

@end

@implementation MOCricleLoadingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // swift 版本
  UIView *view = [[CircleLoadingView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];
  [self.view addSubview:view];
  
  // OC 版本
  UIView *view1 = [[MOCircleLoadingView alloc] initWithFrame:CGRectMake(20, 420, 300, 300)];
  [self.view addSubview:view1];

}


@end

//
//  MOViewTestViewController.m
//  MOSurveyOC
//
//  Created by 莫晓卉 on 2020/12/18.
//

#import "MOViewTestViewController.h"
#import "MOViewTestViewController+LabelPress.h"

@interface MOViewTestViewController ()

@end

@implementation MOViewTestViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self setupView];
}

- (void)setupView {
  // UILabel 耐压缩 测试
  [self labelCompressionResistance];
  
}


@end

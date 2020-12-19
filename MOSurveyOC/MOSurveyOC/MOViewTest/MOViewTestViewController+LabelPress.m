//
//  MOViewTestViewController+LabelPress.m
//  MOSurveyOC
//
//  Created by 莫晓卉 on 2020/12/18.
//

#import "MOViewTestViewController+LabelPress.h"
#import <Masonry/Masonry.h>

@implementation MOViewTestViewController (LabelPress)

// MARK: - UILabel 耐压缩 测试
- (void)labelCompressionResistance {
  UILabel *leftLabel = [[UILabel alloc] init];
  leftLabel.backgroundColor = [UIColor redColor];
  [self.view addSubview:leftLabel];
  leftLabel.text = @"人做的阿唉";
//    [leftLabel sizeToFit];
  
  UILabel *rightLabel = [[UILabel alloc] init];
  rightLabel.backgroundColor = [UIColor greenColor];
  [self.view addSubview:rightLabel];
  rightLabel.text = @"1234567890";
//    [rightLabel sizeToFit];
  
  [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.mas_topLayoutGuide).offset(10);
    make.height.equalTo(@(20));
    make.left.equalTo(self.view).offset(10);
//        make.right.mas_lessThanOrEqualTo(rightLabel.mas_left);
    make.right.equalTo(rightLabel.mas_left).offset(-20);
  }];
  
  [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.equalTo(@(20));
//        make.left.mas_greaterThanOrEqualTo(leftLabel.mas_right);
    make.left.equalTo(leftLabel.mas_right).offset(20);
    make.right.equalTo(self.view).offset(-10);
    make.centerY.equalTo(leftLabel);
  }];
  
  // UILayoutPriorityRequired 1000
  // UILayoutPriorityDefaultHigh 750
  // UILayoutPriorityDefaultLow 250
  // UILayoutPriorityFittingSizeLevel 50
  // 抗压缩力 默认750
  // 抗拉伸力 默认250
  
  // 降低left的 抗压缩力
  [leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

  // 提高right的 抗压缩力
  [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

  // 降低left的 抗拉伸力
  [leftLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
  
  // 降低right的 抗拉伸力
  [rightLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
}

@end

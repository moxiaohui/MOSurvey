//
//  MOLeftDrawerView.h
//  MOSurveyOC
//
//  Created by 莫小言 on 2020/12/18.
//

#import <UIKit/UIKit.h>
#define kMinX 24
#define kMaxX 61
#define kMinOrginX (-(kMaxX-kMinX))
#define kMaxOrginX (0)

NS_ASSUME_NONNULL_BEGIN

@interface MOLeftDrawerView : UIImageView

- (void)close;
- (void)open;

@end

NS_ASSUME_NONNULL_END

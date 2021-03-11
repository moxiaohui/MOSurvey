//
//  MOHeaderAvatarView.h
//  MOSurveyOC
//
//  Created by MikiMo on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MOHeaderAvatarViewDelegate <NSObject>

- (void)clickSubscribeButton;

@end

@interface MOHeaderAvatarView : UIView

@property (nonatomic, assign, getter=isSubscribed) BOOL subscribed;
@property (nonatomic, weak) id<MOHeaderAvatarViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

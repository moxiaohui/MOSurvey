//
//  MOHeaderAvatarView.m
//  MOSurveyOC
//
//  Created by MikiMo on 2021/3/11.
//

#import "MOHeaderAvatarView.h"

static const CGFloat kAvatarImageViewOriginX = 0.0;
static const CGFloat kAvatarImageViewOriginY = 8.0;
static const CGFloat kAvatarImageViewWidthAndHeight = 28.0;
static const CGFloat kAvatarImageViewCornerRaius = 4.0;

static const CGFloat kVipImageViewOriginX = 18.0;
static const CGFloat kVipImageViewOriginY = 24.0;
static const CGFloat kVipImageViewWidthAndHeight = 12.0;
static const CGFloat kVipImageViewCornerRaius = 6.0;

static const CGFloat kNameOriginX = 34;
static const CGFloat kNameOriginY = 12;
static const CGFloat kNameHeight = 22;

static const CGFloat kSubscribeButtonOriginY = 14.0;
static const CGFloat kSubscribeButtonHeight = 18.0;
static const CGFloat kSubscribeButtonWidth = 36.0;
static const CGFloat kSubscribeButtonCornerRadius = 9.0;

static const CGFloat kMutiAvatarViewCornerRadius = 4.0;
static const CGFloat kMutiAvatarViewFirstAvatarOriginX = 3.0;
static const CGFloat kMutiAvatarViewAvatarSpacing = 18.0;
static const CGFloat kMutiAvatarViewAvatarOriginY = 3.0;
static const CGFloat kMutiAvatarViewAvatarWidthAndHeight = 22.0;
static const CGFloat kMutiAvatarViewAvatarCornerRadius = 4.0;
static const CGFloat kMutiAvatarViewAvatarBorderWidth = 1.5;

static const CGFloat kMutiAvatarViewTitleLabelOriginY = 8.0;
static const CGFloat kMutiAvatarViewTitleLabelHeight = 12.0;

static const CGFloat kMutiAvatarViewTitleLabelWithRightImageViewSpacing = 3.0;
static const CGFloat kMutiAvatarViewRightImageViewOriginY = 6.0;
static const CGFloat kMutiAvatarViewRightImageViewWidthAndHeight = 16.0;

static const CGFloat kRelevanceAvatarViewOriginY = 8.0;
static const CGFloat kRelevanceAvatarViewHeight = 28.0;
static const CGFloat kRelevanceAvatarViewWidth = 150.0;


@interface MOMultiAvatarView : UIView

@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSArray <NSString *> *avatars; // 头像数组

@property (nonatomic, strong) UILabel *titleLabel;  // 标题Label
@property (nonatomic, strong) NSMutableArray <UIImageView *> *avatarViews; // 头像视图数组
@property (nonatomic, strong) UIImageView *rightImageView; // ">" icon

@end

@implementation MOMultiAvatarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _avatarViews = [NSMutableArray array];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor grayColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = kMutiAvatarViewCornerRadius;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
            
    _rightImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"mo_right"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    _rightImageView.tintColor = [UIColor whiteColor];
    [self addSubview:_rightImageView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
    [self updateSubViewsFrame];
}

- (void)setAvatars:(NSArray *)avatars {
    _avatars = [avatars copy];
    
    for (UIImageView *avatarImageView in _avatarViews) {
        [avatarImageView removeFromSuperview];
    }
    if (_avatars.count == 0) {
        return;
    }
    // 遍历头像数组，渲染头像
    NSUInteger count = _avatars.count < 3 ? _avatars.count : 3; // 最多显示3个
    CGFloat currentX = 0;
    for (int i = 0; i < count; i++) {
        currentX += i == 0 ? kMutiAvatarViewFirstAvatarOriginX : kMutiAvatarViewAvatarSpacing;
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        avatarImageView.frame = CGRectMake(currentX, kMutiAvatarViewAvatarOriginY, kMutiAvatarViewAvatarWidthAndHeight, kMutiAvatarViewAvatarWidthAndHeight);
        avatarImageView.layer.masksToBounds = YES;
        avatarImageView.layer.cornerRadius = kMutiAvatarViewAvatarCornerRadius;
        avatarImageView.layer.borderWidth = kMutiAvatarViewAvatarBorderWidth;
        avatarImageView.layer.borderColor = [UIColor blackColor].CGColor;
        avatarImageView.backgroundColor = [UIColor whiteColor];
        [_avatarViews addObject:avatarImageView];
        [self addSubview:avatarImageView];
    }
    [self updateSubViewsFrame];
}

#pragma mark - 更新subViews frame
- (void)updateSubViewsFrame {
    // 标题
    CGFloat titleOriginX = CGRectGetMaxX(_avatarViews.lastObject.frame) + 8;
    CGFloat titleWidth = [_titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 12)
                                                        options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName : _titleLabel.font}
                                                        context:nil].size.width;
    _titleLabel.frame = CGRectMake(titleOriginX,
                                   kMutiAvatarViewTitleLabelOriginY,
                                   titleWidth,
                                   kMutiAvatarViewTitleLabelHeight);
    // ">" icon
    CGFloat rightImageViewOriginX = CGRectGetMaxX(_titleLabel.frame) + kMutiAvatarViewTitleLabelWithRightImageViewSpacing;
    _rightImageView.frame = CGRectMake(rightImageViewOriginX,
                                       kMutiAvatarViewRightImageViewOriginY,
                                       kMutiAvatarViewRightImageViewWidthAndHeight,
                                       kMutiAvatarViewRightImageViewWidthAndHeight);
}

@end


@interface MOHeaderAvatarView()

// hostAvatarUrl hostVipImageUrl hostNickName hostSubscribed
// relevaceAvatarUrls
// relevaceAvatarTitle

@property (nonatomic, strong) UIImageView *avatarImageView; // 主账号头像
@property (nonatomic, strong) UIImageView *vipImageView;    // 主账号vip标识
@property (nonatomic, strong) UILabel *nameLabel;           // 主账号昵称
@property (nonatomic, strong) UIButton *subscribeButton;    // 主账号订阅按钮
@property (nonatomic, strong) MOMultiAvatarView *relevanceAvatarView; // 关联账号视图

@end

@implementation MOHeaderAvatarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.backgroundColor = [UIColor blueColor];
        _avatarImageView.backgroundColor = [UIColor whiteColor];
        _vipImageView.backgroundColor = [UIColor orangeColor];
        _nameLabel.text = @"日食记";
        _relevanceAvatarView.title = @"多个战队";
        _relevanceAvatarView.avatars = @[@1, @2, @3];
    }
    return self;
}

- (void)setupView {
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kAvatarImageViewOriginX, kAvatarImageViewOriginY, kAvatarImageViewWidthAndHeight, kAvatarImageViewWidthAndHeight)];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = kAvatarImageViewCornerRaius;
    [self addSubview:_avatarImageView];

    _vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kVipImageViewOriginX, kVipImageViewOriginY, kVipImageViewWidthAndHeight, kVipImageViewWidthAndHeight)];
    _vipImageView.layer.masksToBounds = YES;
    _vipImageView.layer.cornerRadius = kVipImageViewCornerRaius;
    [self addSubview:_vipImageView];

    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];

    _subscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _subscribeButton.layer.cornerRadius = kSubscribeButtonCornerRadius;
    _subscribeButton.layer.masksToBounds = YES;
    _subscribeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    _subscribeButton.backgroundColor = [UIColor orangeColor];
    [_subscribeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_subscribeButton setImage:nil forState:UIControlStateNormal];
    [_subscribeButton setTitle:@"订阅" forState:UIControlStateNormal];
    [_subscribeButton setImage:[UIImage imageNamed:@"mo_check"] forState:UIControlStateSelected];
    [_subscribeButton setTitle:nil forState:UIControlStateSelected];
    [_subscribeButton addTarget:self action:@selector(clickSubscribeButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_subscribeButton];

    _relevanceAvatarView = [[MOMultiAvatarView alloc] initWithFrame:CGRectZero];
    [self addSubview:_relevanceAvatarView];
}

#pragma mark - 点击订阅按钮
- (void)clickSubscribeButton {
    _subscribeButton.selected = !_subscribeButton.selected;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 主账号昵称：自适应宽度
    CGFloat nameWidth = [_nameLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 12)
                                                      options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName : _nameLabel.font}
                                                      context:nil].size.width;
    _nameLabel.frame = CGRectMake(kNameOriginX, kNameOriginY, nameWidth, kNameHeight);
    // 订阅按钮
    _subscribeButton.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame) + 8,
                                        kSubscribeButtonOriginY,
                                        _subscribeButton.selected ? kSubscribeButtonHeight : kSubscribeButtonWidth,
                                        kSubscribeButtonHeight);
    // 关联账号视图
    _relevanceAvatarView.frame = CGRectMake(CGRectGetMaxX(_subscribeButton.frame) + 12,
                                            kRelevanceAvatarViewOriginY,
                                            kRelevanceAvatarViewWidth,
                                            kRelevanceAvatarViewHeight);
}

@end

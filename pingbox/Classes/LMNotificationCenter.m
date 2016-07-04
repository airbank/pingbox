/**
 * Copyright (c) 2016, Air Bank a.s. (www.airbank.cz).
 *
 * All rights reserved. This source code can be used only for purposes specified
 * by the given license contract signed by the rightful deputy of Air Bank a.s.
 * This source code can be used only by the owner of the license.
 *
 * Any disputes arising in respect of this agreement (license) shall be brought
 * before the Municipal Court of Prague.
 *
 */

#import "LMNotificationCenter.h"
#import "LMTopAlignedLabel.h"

@interface LMNotificationCenter ()

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) NSMutableArray *notifications;
@property (nonatomic, strong) UIView *overlayView;

@end

@implementation LMNotificationCenter

+ (LMNotificationCenter*) defaultCenter {
    static dispatch_once_t onceToken;
    static LMNotificationCenter *inst;
    dispatch_once(&onceToken, ^{
        inst = [[LMNotificationCenter alloc] init];
        inst.configuration = [[LMConfiguration alloc] init];
    });
    return inst;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.views = [NSMutableArray array];
        self.notifications = [NSMutableArray array];
    }
    return self;
}

- (void) cancelButtonPressed:(UIButton*)sender {
    __weak UIView *parent = sender.superview;
    NSUInteger index = [self.views indexOfObject:parent];
    LMNotification *notification = [self.notifications objectAtIndex:index];
    [self removeNotification:notification];
    if ([self.delegage respondsToSelector:@selector(didCloseNotification:)]) {
        [self.delegage didCloseNotification:notification];
    }
}

- (void) approveButtonPressed:(UIButton*)sender {
    __weak UIView *parent = sender.superview;
    NSUInteger index = [self.views indexOfObject:parent];
    LMNotification *notification = [self.notifications objectAtIndex:index];
    [self removeNotification:notification];
    if ([self.delegage respondsToSelector:@selector(didOpenNotification:)]) {
        [self.delegage didOpenNotification:notification];
    }
}

- (UIView*) buildNotificationView:(LMNotification*)notification {
    
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = _configuration.backgroundColor;
    view.frame = CGRectMake(
                            _configuration.margin,
                            frame.size.height - _configuration.height - _configuration.margin,
                            frame.size.width - 2 * _configuration.margin,
                            _configuration.height
                            );
    view.layer.cornerRadius = _configuration.cornerRadius;
    view.layer.shadowRadius = _configuration.cornerRadius;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.3;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                    _configuration.innerPadding,
                                                                    _configuration.innerPadding,
                                                                    frame.size.width - 2 * (_configuration.innerPadding + _configuration.margin),
                                                                    _configuration.rowHeight
                                                                    )];
    titleLabel.textColor = _configuration.headingColor;
    titleLabel.textAlignment = _configuration.textAlignment;
    titleLabel.text = notification.title;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [view addSubview:titleLabel];
    
    LMTopAlignedLabel *messageLabel = [[LMTopAlignedLabel alloc] initWithFrame:CGRectMake(
                                                                                          _configuration.innerPadding,
                                                                                          1.5 * _configuration.innerPadding + _configuration.rowHeight,
                                                                                          frame.size.width - 2 * (_configuration.innerPadding + _configuration.margin),
                                                                                          _configuration.rowHeight * 3
                                                                                          )];
    messageLabel.textColor = _configuration.messageColor;
    messageLabel.textAlignment = _configuration.textAlignment;
    messageLabel.numberOfLines = 3;
    messageLabel.text = notification.message;
    messageLabel.font = [UIFont systemFontOfSize:14.0];
    [view addSubview:messageLabel];
    
    CGFloat buttonWidth = (frame.size.width - 2 * _configuration.margin - 2 * _configuration.innerPadding) / 2.0 - (_configuration.buttonGap / 2.0);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = _configuration.cancelButtonBackgroundColor;
    cancelButton.layer.cornerRadius = _configuration.buttonCornerRadius;
    cancelButton.layer.borderColor = _configuration.cancelButtonBorderColor.CGColor;
    cancelButton.layer.borderWidth = 1.0;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    cancelButton.frame = CGRectMake(
                                    _configuration.innerPadding,
                                    _configuration.height - _configuration.innerPadding - _configuration.buttonHeight,
                                    buttonWidth,
                                    _configuration.buttonHeight
                                    );
    [cancelButton setTitle:notification.cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:_configuration.cancelButtonTitleColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    
    UIButton *approveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    approveButton.backgroundColor = _configuration.approveButtonBackgroundColor;
    approveButton.layer.cornerRadius = _configuration.buttonCornerRadius;
    approveButton.layer.borderColor = _configuration.approveButtonBorderColor.CGColor;
    approveButton.layer.borderWidth = 1.0;
    approveButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    approveButton.frame = CGRectMake(
                                     buttonWidth + _configuration.innerPadding + _configuration.buttonGap,
                                     _configuration.height - _configuration.innerPadding - _configuration.buttonHeight,
                                     buttonWidth,
                                     _configuration.buttonHeight
                                     );
    [approveButton setTitle:notification.approveButtonTitle forState:UIControlStateNormal];
    [approveButton setTitleColor:_configuration.approveButtonTitleColor forState:UIControlStateNormal];
    [approveButton addTarget:self action:@selector(approveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:approveButton];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:notification.icon];
    iconView.frame = CGRectMake(
                                view.frame.size.width - 28,
                                -4,32,32
                                );
    iconView.backgroundColor = _configuration.iconBackgroundColor;
    iconView.layer.cornerRadius = 16.0;
    iconView.contentMode = UIViewContentModeCenter;
    [view addSubview:iconView];
    
    // Prepare for transformation
    view.alpha = 0.0;
    view.transform = CGAffineTransformMakeTranslation(0, (_configuration.height + _configuration.margin));
    return view;
}

- (void) animateViews:(UIView*)addView removeView:(UIView*)removeView {
    
    [UIView animateWithDuration:0.3 animations:^{
        addView.alpha = 1.0;
        removeView.alpha = 0.0;
        
        for (int i = 0; i < self.views.count; i++) {
            UIView *view = [self.views objectAtIndex:i];
            view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, - i * (_configuration.height + _configuration.margin));
            [[UIApplication sharedApplication].keyWindow.rootViewController.view bringSubviewToFront:view];
        }
    } completion:^(BOOL finished) {
        [removeView removeFromSuperview];
    }];
}

- (void) postNotification:(LMNotification*)notification {
    
    if ([self.notifications containsObject:notification]) {
        return;
    }
    
    UIView *view = [self buildNotificationView:notification];
    
    @synchronized (self) {
        [self.views insertObject:view atIndex:0];
        [self.notifications insertObject:notification atIndex:0];
    }
    
    if (self.views.count == 1) {
        CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
        self.overlayView = [[UIView alloc] init];
        self.overlayView.frame = frame;
        self.overlayView.backgroundColor = _configuration.overlayColor;
        self.overlayView.userInteractionEnabled = YES;
        self.overlayView.alpha = 0.0;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.overlayView];
        [UIView animateWithDuration:0.2 animations:^{
            self.overlayView.alpha = 1.0;
        }];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    [self animateViews:view removeView:nil];
}

- (void) removeNotification:(LMNotification*)notification {
    
    UIView *view = nil;
    LMNotification *n = nil;
    
    for (int i = 0; i < self.notifications.count; i++) {
        n = [self.notifications objectAtIndex:i];
        if ([n isEqual:notification]) {
            view = [self.views objectAtIndex:i];
            break;
        }
    }
    
    @synchronized (self) {
        [self.views removeObject:view];
        [self.notifications removeObject:notification];
    }
    
    [self animateViews:nil removeView:view];
    
    if (self.views.count == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.overlayView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.overlayView];
            self.overlayView = nil;
        }];
    }
}

- (void) removeAllNotifications {
    while (self.notifications.count > 0) {
        [self removeNotification:[self.notifications objectAtIndex:0]];
    }
}

@end

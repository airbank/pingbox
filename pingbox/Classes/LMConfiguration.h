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

#import <Foundation/Foundation.h>

@interface LMConfiguration : NSObject

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat innerPadding;
@property (nonatomic, assign) CGFloat buttonGap;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat buttonCornerRadius;

@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *overlayColor;
@property (nonatomic, strong) UIColor *headingColor;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIColor *iconBackgroundColor;

@property (nonatomic, strong) UIColor *cancelButtonTitleColor;
@property (nonatomic, strong) UIColor *cancelButtonBackgroundColor;
@property (nonatomic, strong) UIColor *cancelButtonBorderColor;

@property (nonatomic, strong) UIColor *approveButtonTitleColor;
@property (nonatomic, strong) UIColor *approveButtonBackgroundColor;
@property (nonatomic, strong) UIColor *approveButtonBorderColor;

// READ ONLY ATTRIBUTES

@property (nonatomic, assign, readonly) CGFloat rowHeight;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat buttonHeight;

@end

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

#import "LMConfiguration.h"

#define LMNOTIFICATION_PADDING 10.0
#define LMNOTIFICATION_ROW 20.0
#define LMNOTIFICATION_INNER_PADDING 15.0
#define LMNOTIFICATION_HEIGHT 155.0
#define LMNOTIFICATION_BUTTON_HEIGHT 35.0
#define LMNOTIFICATION_BUTTON_GAP 10
#define LMNOTIFICATION_CORNER_RADIUS 8.0
#define LMNOTIFICATION_BUTTON_CORNER_RADIUS 4.0

@interface LMConfiguration ()

@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat buttonHeight;

@end

@implementation LMConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        self.margin = LMNOTIFICATION_PADDING;
        self.innerPadding = LMNOTIFICATION_INNER_PADDING;
        self.height = LMNOTIFICATION_HEIGHT;
        self.rowHeight = LMNOTIFICATION_ROW;
        self.buttonHeight = LMNOTIFICATION_BUTTON_HEIGHT;
        self.buttonGap = LMNOTIFICATION_BUTTON_GAP;
        self.cornerRadius = LMNOTIFICATION_CORNER_RADIUS;
        self.buttonCornerRadius = LMNOTIFICATION_BUTTON_CORNER_RADIUS;
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.headingColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
        self.messageColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        self.overlayColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.iconBackgroundColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.cancelButtonTitleColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
        self.cancelButtonBackgroundColor = [UIColor whiteColor];
        self.cancelButtonBorderColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.approveButtonTitleColor = [UIColor whiteColor];
        self.approveButtonBackgroundColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
        self.approveButtonBorderColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
    }
    return self;
}

@end

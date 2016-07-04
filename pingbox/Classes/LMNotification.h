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

@interface LMNotification : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *approveButtonTitle;
@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, strong) NSDictionary *userInfo;

@end

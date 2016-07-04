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
#import "LMNotification.h"
#import "LMConfiguration.h"

@protocol LMNotificationCenterDelegage <NSObject>

@optional
- (void) didOpenNotification:(LMNotification*)notification;
- (void) didCloseNotification:(LMNotification*)notification;

@end

@interface LMNotificationCenter : NSObject

@property (nonatomic, weak) id<LMNotificationCenterDelegage> delegage;
@property (nonatomic, strong) LMConfiguration *configuration;

+ (LMNotificationCenter*) defaultCenter;

- (void) postNotification:(LMNotification*)notification;
- (void) removeNotification:(LMNotification*)notification;
- (void) removeAllNotifications;

@end

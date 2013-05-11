//
//  WLSTNotificationCenter.h
//  WatchList
//
//  Created by Dmitry Mazuro on 11/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSTNotificationCenter : NSObject<NSUserNotificationCenterDelegate>
- (void)deliverNotificationWithTitle:(NSString *)title informativeText:(NSString *)text;
@end

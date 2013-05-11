//
//  WLSTNotificationCenter.m
//  WatchList
//
//  Created by Dmitry Mazuro on 11/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WLSTNotificationCenter.h"

@implementation WLSTNotificationCenter

- (void)deliverNotificationWithTitle:(NSString *)title informativeText:(NSString *)text{
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = title;
    notification.informativeText = text;
    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

}


- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

@end

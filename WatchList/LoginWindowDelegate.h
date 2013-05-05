//
//  LoginWindowDelegate.h
//  WatchList
//
//  Created by Dmitry Mazuro on 04/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginWindowDelegate <NSObject>
- (void)loggedInUser:(User *)user;
@end


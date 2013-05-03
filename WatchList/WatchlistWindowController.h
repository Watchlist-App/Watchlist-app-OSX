//
//  WatchlistWindowController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "User.h"
#import "SearchViewController.h"

@interface WatchlistWindowController : NSWindowController<SearchDelegate>
@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
- (void)loadWithUserProfile: (User *)userProfile;
@end

//
//  WatchlistWindowController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "User.h"
#import "WatchlistViewController.h"
#import "SearchViewController.h"
#import "MovieInfoViewController.h"
#import "PostersViewController.h"
#import "IMDBFetcher.h"
#import "WatchlistWindowDelegate.h"
#import "WatchlistDelegate.h"

@interface WatchlistWindowController : NSWindowController<SearchDelegate, WatchlistDelegate, MovieInfoDelegate, NSTableViewDelegate>
@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) id<WatchlistWindowDelegate> delegate;
- (void)loadWithUserProfile: (User *)userProfile;
@end

//
//  WatchlistViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Movie+IMDB.h"
#import "WatchlistDelegate.h"


@interface WatchlistViewController : NSViewController

@property (nonatomic,assign) id<WatchlistDelegate> delegate;
@property (strong) NSManagedObjectContext *managedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context;
- (id)initInContext:(NSManagedObjectContext *)context;
@end

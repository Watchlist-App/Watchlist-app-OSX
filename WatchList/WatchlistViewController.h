//
//  WatchlistViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Movie+IMDB.h"

@class WatchlistViewController;

@protocol WatchlistTableDelegate <NSObject>
- (void)infoForMovie:(Movie *)movie;
@end


@interface WatchlistViewController : NSViewController

@property (nonatomic,assign) id<WatchlistTableDelegate> delegate;
@property (strong) NSManagedObjectContext *managedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context;
- (id)initInContext:(NSManagedObjectContext *)context;
@end

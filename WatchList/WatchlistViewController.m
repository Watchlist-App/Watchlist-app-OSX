//
//  WatchlistViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistViewController.h"

@interface WatchlistViewController ()
@property (strong) IBOutlet NSArrayController *watchlistAC;
@property (weak) IBOutlet NSTableView *watchlistTableView;
@property (strong) NSSet *watchlist;
@end

@implementation WatchlistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = context;
    }
    
    return self;
}

- (id)initInContext:(NSManagedObjectContext *)context{
    self = [super initWithNibName:@"WatchlistViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.managedObjectContext = context;
    }
    return self;
}

- (IBAction)infoButtonPressed:(id)sender {
    NSUInteger index = [self.watchlistTableView rowForView:sender];
    Movie *movie = [self.watchlistAC.content objectAtIndex:index];
    [self.delegate clickedInfoForMovie:movie];
}

- (IBAction)deleteMovieClicked:(NSButton *)sender {
    NSUInteger index = [self.watchlistTableView rowForView:sender];
    Movie *movie = [self.watchlistAC.content objectAtIndex:index];
    [self.watchlistAC removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndex:index]];
    [self.delegate clickedRemoveMovie:movie];
}

- (void)setContentSet:(NSSet *)set{
    self.watchlist = set;
}


@end

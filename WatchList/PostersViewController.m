//
//  PostersViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "PostersViewController.h"

@interface PostersViewController ()
@property (weak) IBOutlet NSScrollView *postersScrollView;
@property (weak) IBOutlet NSCollectionView *postersCV;
@property (strong) IBOutlet NSArrayController *watchlistAC;
@property (strong) NSSet *watchlist;


@end

@implementation PostersViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = context;
    }
    
    return self;
}

- (id)initInContext:(NSManagedObjectContext *)context{
    self = [super initWithNibName:@"PostersViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.managedObjectContext = context;

    }
    
    return self;
}

- (void)setBackgroundImageNamed:(NSString *)imageName{
    self.postersScrollView.backgroundColor = [NSColor colorWithPatternImage:[NSImage imageNamed:imageName]];
}

- (IBAction)viewInfoPressed:(id)sender {
    id collectionViewItem = [sender superview];
    NSInteger index = [[self.postersCV subviews]  indexOfObject:collectionViewItem];
    Movie *movie = [self.watchlistAC.content objectAtIndex:index];
    [self.delegate clickedInfoForMovie:movie];
}

- (void)setContentSet:(NSSet *)set{
    self.watchlist = set;
}

@end

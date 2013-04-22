//
//  WatchlistWindowController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistWindowController.h"

@interface WatchlistWindowController ()
@property (weak) IBOutlet NSView *managedView;
@property (weak) IBOutlet NSTableView *sidebarTableView;
@property (weak) IBOutlet NSTableView *searchResultsTableView;
@property (strong) IBOutlet NSView *detailedDescriptionView;
@property (weak) IBOutlet NSCollectionView *postersCollectionView;
@property (weak) IBOutlet NSTableView *watchlistTableView;
@property (strong) IBOutlet NSArrayController *searchResultsArrayController;
@property (strong) IBOutlet NSScrollView *searchResultsScrollView;


@end

@implementation WatchlistWindowController


- (void)windowDidLoad{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"23"]]];
    [self.managedView addSubview:self.searchResultsScrollView];
    NSDictionary *movie = [NSDictionary dictionaryWithObjectsAndKeys:@"spartacus",@"title",@"2013",@"year",nil];
    NSArray *searchResults = [NSArray arrayWithObject:movie];
    self.searchResultsArrayController.content = searchResults;
    
}

- (IBAction)addListClicked:(id)sender {
}

- (IBAction)addMovieClicked:(id)sender {
}

- (IBAction)switchViewClicked:(id)sender {
    
    [self.managedView replaceSubview:self.searchResultsScrollView with:self.postersCollectionView];
}

@end

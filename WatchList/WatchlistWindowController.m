//
//  WatchlistWindowController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistWindowController.h"
#import "IMDBFetcher.h"

@interface WatchlistWindowController ()
@property (weak) IBOutlet NSView *managedView;
@property (weak) IBOutlet NSTableView *sidebarTableView;
@property (strong) IBOutlet NSView *detailedDescriptionView;
@property (weak) IBOutlet NSCollectionView *postersCollectionView;
@property (strong) IBOutlet NSArrayController *searchResultsArrayController;
@property (weak) IBOutlet NSTextField *searchTextField;
@property (strong) IBOutlet NSViewController *popoverViewController;
@property (strong) IBOutlet NSPopover *popover;
@property (strong) IBOutlet NSScrollView *postersScrollView;
@property (weak) IBOutlet NSProgressIndicator *searchProgressSpinner;
@property (weak) IBOutlet NSTableView *searchResultsTable;
@property (strong) IBOutlet NSScrollView *searchResultsScrollView;
@property (weak) IBOutlet NSScrollView *watchlistScrollView;
@property (weak) IBOutlet NSTableView *watchlistTable;

@end

@implementation WatchlistWindowController


- (void)windowDidLoad{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"23"]]];
    //[self.managedView addSubview:self.searchResultsScrollView];
    NSImage* photo = [NSImage imageNamed:@"band-of-brothers-poster-1.jpg"];
    NSDictionary *movie = [NSDictionary dictionaryWithObjectsAndKeys:@"spartacus",@"title",@"2013",@"year", photo, @"photo",nil];
    NSMutableArray *searchResults = [NSMutableArray arrayWithObject:movie];
    for (int i = 0; i < 100; i++) {
        [searchResults addObject:movie];
    }
    self.searchResultsArrayController.content = searchResults;
    
}

- (IBAction)addListClicked:(id)sender {
}

- (IBAction)searchClicked:(id)sender {
    [self.searchProgressSpinner startAnimation:self];
    dispatch_queue_t fetchQueue = dispatch_queue_create("IMDB Fetch", NULL);
    dispatch_async(fetchQueue, ^{
        self.searchResultsArrayController.content = [IMDBFetcher searchMoviesByTitle:self.searchTextField.stringValue];
        [self.searchResultsArrayController.content enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            NSURL *imageURL = [NSURL URLWithString:[object valueForKey:@"poster"]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            NSImage *posterImage;
            if (imageData) {
                posterImage = [[NSImage alloc] initWithData:imageData];
            } else{
                posterImage = [NSImage imageNamed:@"NSUser"];
            }
            
            [object setValue:posterImage forKey:@"photo"];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.searchProgressSpinner stopAnimation:self];
        });
    });
}

- (IBAction)addMovieClicked:(NSButton*)sender {
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}

- (IBAction)switchViewClicked:(NSSegmentedControl*)sender {
    if (sender.selectedSegment == 0) {
        [self.window.contentView replaceSubview:self.postersScrollView with:self.watchlistScrollView];

    } else
    [self.window.contentView replaceSubview:self.watchlistScrollView with:self.postersScrollView];
}

@end

//
//  WatchlistWindowController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistWindowController.h"
#import "IMDBFetcher.h"
#import "MovieInfoViewController.h"
#import <Quartz/Quartz.h>
#import "Movie+IMDB.h"
#import "SearchViewController.h"
#import "WatchlistViewController.h"
#import "PostersViewController.h"

@interface WatchlistWindowController ()

@property (weak) IBOutlet NSView *managedView;
@property (weak) IBOutlet NSTableView *sidebarTableView;
@property (weak) IBOutlet NSTextField *searchTextField;
@property (strong) IBOutlet NSViewController *popoverViewController;
@property (strong) IBOutlet NSPopover *popover;
@property (weak) IBOutlet NSImageView *userIconView;
@property (weak) IBOutlet NSTextField *usernameLabel;


@property (strong) NSString *username;
@property (strong) NSImage *userPicture;
@property (strong, nonatomic) MovieInfoViewController *movieInfoVC;
@property (strong, nonatomic) SearchViewController *searchVC;
@property (strong, nonatomic) WatchlistViewController *watchlistVC;
@property (strong, nonatomic) PostersViewController *posterVC;

@end

@implementation WatchlistWindowController

- (void)loadWithUserProfile: (User *)userProfile{
    self.username = userProfile.login;
    self.userPicture = userProfile.profilePicture;
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"woodBackground"]]];
    [self showWindow:self];
}


- (void)windowDidLoad{
    [super windowDidLoad];
    self.usernameLabel.stringValue = self.username;
    self.userIconView.image = self.userPicture;
    
    [self.window.contentView setWantsLayer:YES];
    
    self.watchlistVC.view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:self.watchlistVC.view];
    self.managedView = self.watchlistVC.view;
}




- (IBAction)searchClicked:(id)sender {
    NSView *view = [self.searchVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.searchVC searchForMovie:self.searchTextField.stringValue];
}



- (IBAction)addMovieClicked:(NSButton*)sender {
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}


- (IBAction)switchViewClicked:(NSSegmentedControl*)sender {
    
    if (sender.selectedSegment == 0) {
        self.watchlistVC.view.frame = self.managedView.frame;
        [[self.window.contentView animator] replaceSubview:self.managedView with:self.watchlistVC.view];
        self.managedView = self.watchlistVC.view;

    } else{
        self.posterVC.view.frame = self.managedView.frame;
        [[self.window.contentView animator] replaceSubview:self.managedView with:self.posterVC.view];
        [self.posterVC setBackgroundImageNamed:@"linen.png"];
        self.managedView = self.posterVC.view;
    }
    
}




- (MovieInfoViewController *)movieInfoVC{
    if (!_movieInfoVC) {
        _movieInfoVC  = [[MovieInfoViewController alloc] initWithNibName:@"MovieInfoViewController" bundle:[NSBundle mainBundle]];
    }
    return _movieInfoVC;
}

- (SearchViewController *)searchVC{
    if (!_searchVC) {
        _searchVC = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];
        _searchVC.delegate = self;
    }
    return _searchVC;
}

- (WatchlistViewController *)watchlistVC{
    if (!_watchlistVC) {
        _watchlistVC = [[WatchlistViewController alloc] initInContext:self.managedObjectContext];
    }
    return _watchlistVC;
}

- (PostersViewController *)posterVC{
    if (!_posterVC) {
        _posterVC = [[PostersViewController alloc] initInContext:self.managedObjectContext];
    }
    return _posterVC;
}

//delegate methods
- (void)selectedMovieWithID:(NSString *)imdbID{
    NSLog(@"%@",imdbID);
    NSDictionary *imdbDictionary = [IMDBFetcher searchMoiveByID:imdbID];
    [Movie movieWithIMDBDictionary:imdbDictionary inManagedObjectContext:self.managedObjectContext];
    NSLog([imdbDictionary description]);
}

@end

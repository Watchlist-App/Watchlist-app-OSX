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

@interface WatchlistWindowController ()

@property (weak) IBOutlet NSView *managedView;
@property (weak) IBOutlet NSTableView *sidebarTableView;
@property (weak) IBOutlet NSCollectionView *postersCollectionView;
@property (weak) IBOutlet NSTextField *searchTextField;
@property (strong) IBOutlet NSViewController *popoverViewController;
@property (strong) IBOutlet NSPopover *popover;
@property (strong) IBOutlet NSScrollView *postersScrollView;
@property (weak) IBOutlet NSTableView *watchlistTable;
@property (weak) IBOutlet NSImageView *userIconView;
@property (weak) IBOutlet NSTextField *usernameLabel;
@property (strong) IBOutlet NSScrollView *watchlistScrollView;


@property (strong) NSString *username;
@property (strong) NSImage *userPicture;
@property (strong) MovieInfoViewController *movieInfoVC;
@property (strong) SearchViewController *searchVC;


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
    
    self.watchlistScrollView.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:self.watchlistScrollView];
    self.managedView = self.watchlistScrollView;
    
    [self.window.contentView setWantsLayer:YES];
    self.searchVC = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];

    
    
  

}

- (IBAction)addListClicked:(NSButton *)sender {
    
}

- (IBAction)searchClicked:(id)sender {
    NSView *view = [self.searchVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    [self.searchVC searchForMovie:self.searchTextField.stringValue];
}



- (IBAction)addMovieClicked:(NSButton*)sender {
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}


- (IBAction)switchViewClicked:(NSSegmentedControl*)sender {
    if (sender.selectedSegment == 0) {
        self.watchlistScrollView.frame = self.managedView.frame;
        [[self.window.contentView animator] replaceSubview:self.managedView with:self.watchlistScrollView];
        self.managedView = self.watchlistScrollView;

    } else{
        self.postersScrollView.frame = self.managedView.frame;
        [[self.window.contentView animator] replaceSubview:self.managedView with:self.postersScrollView];
        self.managedView = self.postersScrollView;
    }
}

@end

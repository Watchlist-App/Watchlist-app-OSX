//
//  WatchlistWindowController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistWindowController.h"

@interface WatchlistWindowController ()

//views
@property (weak) IBOutlet NSView *managedView;
@property (weak) IBOutlet NSTableView *sidebarTableView;

//search popover
@property (weak) IBOutlet NSTextField *searchTextField;

//add list popover
@property (weak) IBOutlet NSImageView *listIconView;
@property (weak) IBOutlet NSTextField *listTitleTextField;
@property (weak) IBOutlet NSPopUpButton *typePopUpButton;


//window toolbar
@property (weak) IBOutlet NSButton *userIcon;
@property (weak) IBOutlet NSTextField *usernameLabel;


@property (strong, nonatomic) User *user;
@property (strong, nonatomic) List *selectedList;

//view controllers
@property (strong, nonatomic) MovieInfoViewController *movieInfoVC;
@property (strong, nonatomic) SearchViewController *searchVC;
@property (strong, nonatomic) WatchlistViewController *watchlistVC;
@property (strong, nonatomic) PostersViewController *posterVC;


@property (strong) IBOutlet NSArrayController *sidebarAC;

//popover
@property (strong, nonatomic)  NSPopover *popover;
@property (strong, nonatomic)  NSViewController *popoverViewController;
@property (weak) IBOutlet NSView *addListPopoverView;
@property (weak) IBOutlet NSView *searchPopoverView;
@property (weak) IBOutlet NSView *userIconPopover;

@end

@implementation WatchlistWindowController

- (void)loadWithUserProfile: (User *)userProfile{
    self.user = userProfile;
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"woodBackground"]]];
    [self showWindow:self];
}



- (void)windowDidLoad{
    [super windowDidLoad];
    self.usernameLabel.stringValue = self.user.login;
    self.userIcon.image = self.user.profilePicture;
    
    [self.window.contentView setWantsLayer:YES];
    [self.sidebarTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    self.watchlistVC.view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:self.watchlistVC.view];
    self.managedView = self.watchlistVC.view;    
}


//actions

- (IBAction)userIconClicked:(NSButton *)sender {

    self.popoverViewController.view = self.userIconPopover;
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}

- (IBAction)addListClicked:(NSButton *)sender {
    self.popoverViewController.view = self.addListPopoverView;
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}

- (IBAction)addMovieClicked:(NSButton*)sender {
    self.popoverViewController.view = self.searchPopoverView;
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}


- (IBAction)searchClicked:(id)sender {
    NSView *view = [self.searchVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.searchVC searchForMovie:self.searchTextField.stringValue];
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSUInteger index = self.sidebarTableView.selectedRow;
    self.selectedList = [self.sidebarAC.content objectAtIndex:index];
    [self.watchlistVC setContentSet:self.selectedList.movies];
    [self.posterVC setContentSet:self.selectedList.movies];

}


- (IBAction)settingsClicked:(id)sender {
    
}


- (IBAction)logOutClicked:(id)sender {
    [self.delegate userLoggedOut];
}


- (IBAction)adListConfirmed:(id)sender {
    
    List *newList = [[List alloc] initWithEntity:[NSEntityDescription entityForName:@"List" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext];
    newList.title = self.listTitleTextField.stringValue;
    newList.icon = self.listIconView.image;
    newList.owner = self.user;
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



//delegate methods
- (void)selectedMovieWithID:(NSString *)imdbID{
    dispatch_queue_t fetchQueue = dispatch_queue_create("Movie info fetch", NULL);
    dispatch_async(fetchQueue, ^{
        NSDictionary *imdbDictionary = [IMDBFetcher searchMoiveByID:imdbID];
        [Movie movieWithIMDBDictionary:imdbDictionary forList:self.selectedList inManagedObjectContext:self.managedObjectContext];
    });
    
}

- (void)pressedInfoForMovie:(Movie *)movie{
    [self.movieInfoVC setMovie:movie];
    self.movieInfoVC.view.frame = self.managedView.frame;
    [[[self.window contentView] animator] replaceSubview:self.managedView with:self.movieInfoVC.view];
    self.managedView = self.movieInfoVC.view;
}

- (void)backToListPressed{
    self.watchlistVC.view.frame = self.managedView.frame;
    [[self.window.contentView animator] replaceSubview:self.managedView with:self.watchlistVC.view];
    self.managedView = self.watchlistVC.view;
}


//Lazy instantiation getters
- (MovieInfoViewController *)movieInfoVC{
    if (!_movieInfoVC) {
        _movieInfoVC  = [[MovieInfoViewController alloc] initWithNibName:@"MovieInfoView" bundle:[NSBundle mainBundle]];
        _movieInfoVC.delegate = self;
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
        _watchlistVC.delegate = self;
    }
    return _watchlistVC;
}

- (PostersViewController *)posterVC{
    if (!_posterVC) {
        _posterVC = [[PostersViewController alloc] initInContext:self.managedObjectContext];
        _posterVC.delegate = self;
    }
    return _posterVC;
}

- (NSPopover *)popover{
    _popover = [[NSPopover alloc] init];
    _popover.behavior = NSPopoverBehaviorSemitransient;
    _popover.contentViewController = self.popoverViewController;
    return _popover;
}

- (NSViewController *)popoverViewController{
    if (!_popoverViewController) {
        _popoverViewController = [[NSViewController alloc] init];
    }
    return _popoverViewController;
}

@end

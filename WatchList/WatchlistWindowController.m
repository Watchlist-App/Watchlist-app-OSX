//
//  WatchlistWindowController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 22/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistWindowController.h"
#import "List+Create.h"
#import "MovieInfoViewController.h"
#import "TheMovieDbFetcher.h"
#import "WLSTNotificationCenter.h"

@interface WatchlistWindowController ()

//managed view
@property (weak) IBOutlet NSView *managedView;

//sidebar
@property (strong) IBOutlet NSTableView *sidebarTableView;
@property (strong) IBOutlet NSArrayController *sidebarAC;

//window toolbar
@property (weak) IBOutlet NSButton *userIcon;
@property (weak) IBOutlet NSTextField *usernameLabel;
@property (weak) IBOutlet NSSegmentedControl *viewSwitcher;

//core data
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) List *selectedList;
@property (strong, nonatomic) List *watchlist;


//view controllers
@property (strong, nonatomic) internetListViewController *internetListVC;
@property (strong, nonatomic) WatchlistViewController *watchlistVC;
@property (strong, nonatomic) PostersViewController *posterVC;

@property (strong, nonatomic) MovieInfoViewController *movieInfoVC;


//popover
@property (strong, nonatomic)  NSPopover *popover;
@property (strong, nonatomic)  NSViewController *popoverViewController;
@property (weak) IBOutlet NSView *addListPopoverView;
@property (weak) IBOutlet NSView *userIconPopover;
@property (strong) IBOutlet NSView *discoverPopoverView;

//add list popover
@property (weak) IBOutlet NSImageView *listIconView;
@property (weak) IBOutlet NSTextField *listTitleTextField;

@end



@implementation WatchlistWindowController

- (void)loadWithUserProfile:(User *)userProfile{
    self.user = userProfile;
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"woodBackground"]]];
    [self showWindow:self];
}



- (void)windowDidLoad{
    [super windowDidLoad];
    [self.window makeFirstResponder:nil];
    self.usernameLabel.stringValue = self.user.login;
    self.userIcon.image = self.user.profilePicture;
    
    [self.window.contentView setWantsLayer:YES];
    [self.sidebarTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    
    self.watchlistVC.view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:self.watchlistVC.view];
    self.managedView = self.watchlistVC.view;
    self.watchlist = [List listWithTitle:@"Watchlist" forUser:self.user inManagedObjectContext:self.managedObjectContext];
    
    [[NSApp dockTile] setBadgeLabel:[NSString stringWithFormat:@"%ld",self.watchlist.movies.count]];
    [self.watchlist addObserver:self forKeyPath:@"movies" options:0 context:NULL];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == NULL) {
        NSSet *movies = [object valueForKeyPath:keyPath];
    	[[NSApp dockTile] setBadgeLabel:[NSString stringWithFormat:@"%ld",movies.count]];
    }
    else {
    	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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


- (IBAction)discoverClicked:(NSButton *)sender {
    self.popoverViewController.view = self.discoverPopoverView;
    [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMinYEdge];
}



- (IBAction)searchFieldConfirmed:(NSSearchField *)sender {
    NSView *view = [self.internetListVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.internetListVC setListDictionary:[TheMovieDbFetcher searchMoviesByTitle:[sender stringValue]]];

}


- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSUInteger index = self.sidebarTableView.selectedRow;
    self.selectedList = [self.sidebarAC.content objectAtIndex:index];
    [self.watchlistVC setContentSet:self.selectedList.movies];
    [self.posterVC setContentSet:self.selectedList.movies];
    [self switchViewClicked:self.viewSwitcher];

}


- (IBAction)settingsClicked:(id)sender {
    
}


- (IBAction)logOutClicked:(id)sender {
    [self.delegate userLoggedOut];
}


- (IBAction)adListConfirmed:(id)sender {
    [List ListWithTitle:self.listTitleTextField.stringValue icon:self.listIconView.image forUser:self.user inManagedObjectContext:self.managedObjectContext];
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


//discover popover
- (IBAction)genresClicked:(id)sender {
}

- (IBAction)popularClicked:(id)sender {
    NSView *view = [self.internetListVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.internetListVC setListDictionary:[TheMovieDbFetcher popularMovies]];

}

- (IBAction)upcomingClicked:(id)sender {
    NSView *view = [self.internetListVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.internetListVC setListDictionary:[TheMovieDbFetcher upcomingMovies]];

}

- (IBAction)topRatedClicked:(id)sender {
    NSView *view = [self.internetListVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.internetListVC setListDictionary:[TheMovieDbFetcher topRatedMovies]];

}

- (IBAction)nowPlayingClicked:(id)sender {
    NSView *view = [self.internetListVC view];
    view.frame = self.managedView.frame;
    [self.window.contentView replaceSubview:self.managedView with:view];
    self.managedView = view;
    [self.internetListVC setListDictionary:[TheMovieDbFetcher nowPlayingMovies]];

}

//delegate methods


- (void)addToSelectedListMovieWithID:(NSString *)tmdbID{
    dispatch_queue_t fetchQueue = dispatch_queue_create("Movie info fetch", NULL);
    dispatch_async(fetchQueue, ^{
        NSDictionary *tmdbDictionary = [TheMovieDbFetcher infoForMovieID:tmdbID.intValue];
        Movie *movie = [Movie movieWithTMDBDictionary:tmdbDictionary inManagedObjectContext:self.managedObjectContext];
        [self.selectedList addMoviesObject:movie];
        
        [WLSTNotificationCenter deliverNotificationWithTitle: @"Movie succesfully added" informativeText:[NSString stringWithFormat:@"%@ was added to %@",movie.title, self.selectedList.title]];
    });
}

- (void)addToWatchlistMovieWithID:(NSString *)tmdbID{
    dispatch_queue_t fetchQueue = dispatch_queue_create("Movie info fetch", NULL);
    dispatch_async(fetchQueue, ^{
        NSDictionary *tmdbDictionary = [TheMovieDbFetcher infoForMovieID:tmdbID.intValue];
        Movie *movie = [Movie movieWithTMDBDictionary:tmdbDictionary inManagedObjectContext:self.managedObjectContext];
        List *watchlist = [List listWithTitle:@"Watchlist" forUser:self.user inManagedObjectContext:self.managedObjectContext];
        [watchlist addMoviesObject:movie];
        
        [WLSTNotificationCenter deliverNotificationWithTitle:@"Movie succesfully added" informativeText:[NSString stringWithFormat:@"%@ was added to your watchlist",movie.title]];
    });
}

- (void)addToFavoritesMovieWithID:(NSString *)tmdbID{
    dispatch_queue_t fetchQueue = dispatch_queue_create("Movie info fetch", NULL);
    dispatch_async(fetchQueue, ^{
        NSDictionary *tmdbDictionary = [TheMovieDbFetcher infoForMovieID:tmdbID.intValue];
        Movie *movie = [Movie movieWithTMDBDictionary:tmdbDictionary inManagedObjectContext:self.managedObjectContext];
        List *watchlist = [List listWithTitle:@"Favorites" forUser:self.user inManagedObjectContext:self.managedObjectContext];
        [watchlist addMoviesObject:movie];
        
        [WLSTNotificationCenter deliverNotificationWithTitle:@"Movie succesfully added" informativeText:[NSString stringWithFormat:@"%@ was added to favorites",movie.title]];

    });
}

- (void)addToWatchedMovieWithID:(NSString *)tmdbID{
    dispatch_queue_t fetchQueue = dispatch_queue_create("Movie info fetch", NULL);
    dispatch_async(fetchQueue, ^{
        NSDictionary *tmdbDictionary = [TheMovieDbFetcher infoForMovieID:tmdbID.intValue];
        Movie *movie = [Movie movieWithTMDBDictionary:tmdbDictionary inManagedObjectContext:self.managedObjectContext];
        List *watchlist = [List listWithTitle:@"Watched movies" forUser:self.user inManagedObjectContext:self.managedObjectContext];
        [watchlist addMoviesObject:movie];
        
        [WLSTNotificationCenter deliverNotificationWithTitle:@"Movie succesfully added" informativeText:[NSString stringWithFormat:@"%@ was marked as watched",movie.title]];

    });
}


- (void)clickedInfoForMovie:(Movie *)movie{
    
    
    
    
    self.movieInfoVC = [[MovieInfoViewController alloc] initWithNibName:@"MovieInfoViewController" bundle:[NSBundle mainBundle]];

    [self.movieInfoVC setMovie:movie];
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.managedView.frame];
    
    // configure the scroll view
    [scrollView setBorderType:NSNoBorder];
    [scrollView setHasVerticalScroller:YES];
    //[scrollView setHasHorizontalScroller:YES];
    [scrollView setAutoresizesSubviews:YES];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    // embed your custom view in the scroll view
    [scrollView setDocumentView:self.movieInfoVC.view];
    
    // set the scroll view as the content view of your window
    [self.window.contentView replaceSubview:self.managedView with:scrollView];
    self.managedView = scrollView;
    
    
    if ([scrollView hasVerticalScroller]) {
        scrollView.verticalScroller.floatValue = 0;
    }
    
    // Scroll the contentView to top
    [scrollView.contentView scrollToPoint:NSMakePoint(0, ((NSView*)scrollView.documentView).frame.size.height - scrollView.contentSize.height)];

}


- (void)clickedRemoveMovie:(Movie *)movie{
    [self.selectedList removeMoviesObject:movie];
}

- (void)backToListPressed{
    self.watchlistVC.view.frame = self.managedView.frame;
    [[self.window.contentView animator] replaceSubview:self.managedView with:self.watchlistVC.view];
    self.managedView = self.watchlistVC.view;
}


//Lazy instantiation getters



- (internetListViewController *)internetListVC{
    if (!_internetListVC) {
        _internetListVC = [[internetListViewController alloc] initWithNibName:@"internetListViewController" bundle:[NSBundle mainBundle]];
        _internetListVC.delegate = self;
    }
    return _internetListVC;
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

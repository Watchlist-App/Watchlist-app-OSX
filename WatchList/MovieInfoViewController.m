//
//  MovieInfoViewController.m
//  TheMovieDBTest
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "MovieInfoViewController.h"
#import "TheMovieDbFetcher.h"
#import "YouTubeFetcher.h"
#import "CastViewController.h"
#import "SmallPostersViewController.h"
#import "WLSTEventCreator.h"
#import "WLSTNotificationCenter.h"

@interface MovieInfoViewController ()
@property (strong, nonatomic) SmallPostersViewController *smallPostersVC;
@property (strong, nonatomic) CastViewController *castVC;
@property (weak) IBOutlet NSButton *calendarButton;
@property (weak) IBOutlet NSView *recommendationsView;
@property (weak) IBOutlet NSView *actorsView;
@property (weak) IBOutlet NSTextField *trailerLabel;
@property (weak) IBOutlet NSTextField *castLabel;
@property (weak) IBOutlet NSTextField *similarMoviesLabel;
@property (weak) IBOutlet NSButton *shareButton;

@end

@implementation MovieInfoViewController



- (IBAction)addToCalendarClicked:(id)sender {
    NSString *title = self.movie.title;
    NSDate *date = self.movie.releaseDate;
    [WLSTEventCreator addEventNamed:[NSString stringWithFormat:@"%@ release",title] description:[NSString stringWithFormat:@"Premiere of the movie \"%@\"",title] date:date];
    NSString *notificationMessage = [NSString stringWithFormat:@"%@ release date: %@ was saved to your calendar", title, [date descriptionWithCalendarFormat:@"%d.%m.%Y" timeZone:nil locale:nil]];
    [WLSTNotificationCenter deliverNotificationWithTitle:@"Movie premiere was added to calendar" informativeText:notificationMessage];
     
}

- (SmallPostersViewController*)smallPostersVC{
    if (!_smallPostersVC) {
        _smallPostersVC = [[SmallPostersViewController alloc] initWithNibName:@"SmallPostersViewController" bundle:[NSBundle mainBundle]];
    }
    return _smallPostersVC;
}

- (CastViewController*)castVC{
    if (!_castVC) {
        _castVC = [[CastViewController alloc] initWithNibName:@"CastViewController" bundle:[NSBundle mainBundle]];
    }
    return _castVC;
}

- (void)viewWillLoad {
}

- (void)viewDidLoad {
    
    
    [self.posterView setImage:self.movie.posterPicture];
    [self.shareButton setImage:[NSImage imageNamed:NSImageNameShareTemplate]];
    [self.shareButton sendActionOn:NSLeftMouseDownMask];

    [self.titleLabel setStringValue:self.movie.title];
    [self.releaseDateLabel setStringValue:[self.movie.releaseDate descriptionWithCalendarFormat:@"%d-%m-%Y" timeZone:nil locale:nil]];
    [self.budgetLabel setIntValue:self.movie.budget.intValue];
    [self.revenueLabel setIntValue:self.movie.revenue.intValue];
    [self.runtimeLabel setStringValue:self.movie.runtime];
    [self.plotLabel setStringValue:self.movie.plot];
    [self.companiesLabel setStringValue:self.movie.productionCompanies];
    [self.genresLabel setStringValue:self.movie.genres];
    [self.countriesLabel setStringValue:self.movie.countries];
    [self.ratingLabel setFloatValue:self.movie.rating.floatValue];
    
    if ([self.movie.releaseDate compare:[NSDate date]] == NSOrderedAscending) {
        [self.calendarButton setHidden:YES];
    } else [self.calendarButton setHidden:NO];
    
    
    
    if ([self.movie.youTubeTrailerID length] > 0) {
        [self.youTubePlayerView.mainFrame loadHTMLString:[YouTubeFetcher youtubeHTMLForID:self.movie.youTubeTrailerID] baseURL:nil];
    } else {
        [self.youTubePlayerView removeFromSuperview];
        [self.trailerLabel removeFromSuperview];
    }

    self.castVC.view.frame = self.actorsView.frame;
    [self.view replaceSubview:self.actorsView with:self.castVC.view];
        self.actorsView = self.castVC.view;
    
    self.smallPostersVC.view.frame = self.recommendationsView.frame;
    [self.view replaceSubview:self.recommendationsView with:self.smallPostersVC.view];
       self.recommendationsView = self.smallPostersVC.view;
    
    
    dispatch_queue_t castAndRecommendationsFetch = dispatch_queue_create("Cast and recommendations fetch", NULL);
    dispatch_async(castAndRecommendationsFetch, ^{
        NSArray *cast = [[TheMovieDbFetcher castForMovieID:self.movie.tmdbID.intValue] valueForKey:@"cast"];
        NSArray *similarMovies = [[TheMovieDbFetcher recommendationsForMovieID:self.movie.tmdbID.intValue] valueForKey:@"results"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cast.count) {
                [self.castVC setCastArray:cast];
            } else{
                [self.castVC.view removeFromSuperview];
                [self.castLabel removeFromSuperview];
            }
            
            if (similarMovies.count) {
                [self.smallPostersVC setListArray:similarMovies];
            } else {
                [self.smallPostersVC.view removeFromSuperview];
                [self.similarMoviesLabel removeFromSuperview];
            }
        });

    });
    
    
}

- (void)loadView {
    [self viewWillLoad];
    [super loadView];
    [self viewDidLoad];
}


- (IBAction)shareClicked:(NSButton *)sender {
    NSMutableArray *shareItems = [NSMutableArray arrayWithObject:self.titleLabel.attributedStringValue];
    
    NSImage *image = [self.posterView image];
    if (image) {
        [shareItems addObject:image];
    }
    
    [shareItems addObject:self.movie.website];
    
    NSSharingServicePicker *sharingServicePicker = [[NSSharingServicePicker alloc] initWithItems:shareItems];
    sharingServicePicker.delegate = self;
    
    [sharingServicePicker showRelativeToRect:[sender bounds]
                                      ofView:sender
                               preferredEdge:NSMinYEdge];
}



#pragma mark - Sharing service picker delegate methods

- (id <NSSharingServiceDelegate>)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker delegateForSharingService:(NSSharingService *)sharingService
{
    return self;
}





#pragma mark - Sharing service delegate methods

- (NSRect)sharingService:(NSSharingService *)sharingService sourceFrameOnScreenForShareItem:(id<NSPasteboardWriting>)item
{
    if ([item isKindOfClass:[NSImage class]]) {
        NSImage * image = [self.posterView image];
        NSRect frame = [self.posterView bounds];
        frame = [self.posterView convertRect:frame toView:nil];
        frame.origin = [[self.posterView window] convertBaseToScreen:frame.origin];
        return frame;
    }
    return NSZeroRect;
}

- (NSImage *)sharingService:(NSSharingService *)sharingService transitionImageForShareItem:(id<NSPasteboardWriting>)item contentRect:(NSRect *)contentRect
{
    if ([item isKindOfClass:[NSImage class]]) {
        return [self.posterView image];
    }
    else {
        return nil;
    }
}


- (NSWindow *)sharingService:(NSSharingService *)sharingService sourceWindowForShareItems:(NSArray *)items sharingContentScope:(NSSharingContentScope *)sharingContentScope
{

    return self.view.window;
}




@end

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
@property (strong, nonatomic) NSDate *movieReleaseDate;
@property (strong, nonatomic) NSString *movieTitle;
@property (weak) IBOutlet NSButton *calendarButton;

@end

@implementation MovieInfoViewController

- (void)setMovie:(Movie *)movie{
    [self.posterView setImage:movie.posterPicture];
    [self.titleLabel setStringValue:movie.title];
    [self.releaseDateLabel setStringValue:[movie.releaseDate descriptionWithCalendarFormat:@"%d-%m-%Y" timeZone:nil locale:nil]];
    [self.budgetLabel setIntValue:movie.budget.intValue];
    [self.revenueLabel setIntValue:movie.revenue.intValue];
    [self.runtimeLabel setStringValue:movie.runtime];
    [self.plotLabel setStringValue:movie.plot];
    [self.companiesLabel setStringValue:movie.productionCompanies];
    [self.genresLabel setStringValue:movie.genres];
    [self.countriesLabel setStringValue:movie.countries];
    [self.ratingLabel setFloatValue:movie.rating.floatValue];
    
    self.movieReleaseDate = movie.releaseDate;
    self.movieTitle = movie.title;
    if ([movie.releaseDate compare:[NSDate date]] == NSOrderedAscending) {
        [self.calendarButton setHidden:YES];
    } else [self.calendarButton setHidden:NO];
    
    [self.youTubePlayerView.mainFrame loadHTMLString:[YouTubeFetcher youtubeHTMLForID:movie.youTubeTrailerID] baseURL:nil];
    
    self.smallPostersVC.view.frame = self.similarMoviesView.frame;
    [self.view replaceSubview:self.similarMoviesView with:self.smallPostersVC.view];
    NSArray *similarMovies = [[TheMovieDbFetcher recommendationsForMovieID:movie.tmdbID.intValue] valueForKey:@"results"];
    [self.smallPostersVC setListArray:similarMovies];
    self.similarMoviesView = self.smallPostersVC.view;
    
    
    self.castVC.view.frame = self.castView.frame;
    [self.view replaceSubview:self.castView with:self.castVC.view];
    NSArray *cast = [[TheMovieDbFetcher castForMovieID:movie.tmdbID.intValue] valueForKey:@"cast"];
    [self.castVC setCastArray:cast];
    self.castView = self.castVC.view;
}

- (void)setMovieDictionary:(NSDictionary *)movie{
    
    dispatch_queue_t posterFetchQueue = dispatch_queue_create("poster fetch", NULL);
    dispatch_async(posterFetchQueue, ^{
        [self.posterView setImage:[TheMovieDbFetcher imageWithPath:[movie valueForKey:@"poster_path"] size:@"original"]];
    });
    [self.titleLabel setStringValue:[movie valueForKey:@"title"]];
    [self.releaseDateLabel setStringValue:[movie valueForKey:@"release_date"]];
    [self.budgetLabel setStringValue:[movie valueForKey:@"budget"]];
    [self.revenueLabel setStringValue:[movie valueForKey:@"revenue"]];
    [self.runtimeLabel setStringValue:[movie valueForKey:@"runtime"]];
    [self.plotLabel setStringValue:[movie valueForKey:@"overview"]];
    [self.ratingLabel setStringValue:[movie valueForKey:@"vote_average"]];
    
    NSArray *youTubetrailers = [[TheMovieDbFetcher trailersForMovieID:550] valueForKey:@"youtube"];
    NSString *youTubeID = [youTubetrailers[0] valueForKey:@"source"];

    
    [self.youTubePlayerView.mainFrame loadHTMLString:[YouTubeFetcher youtubeHTMLForID:youTubeID] baseURL:nil];
    
    
    self.smallPostersVC.view.frame = self.similarMoviesView.frame;
    [self.view replaceSubview:self.similarMoviesView with:self.smallPostersVC.view];
    NSArray *list = [[TheMovieDbFetcher recommendationsForMovieID:550] valueForKey:@"results"];
    [self.smallPostersVC setListArray:list];
    
    self.castVC.view.frame = self.castView.frame;
    [self.view replaceSubview:self.castView with:self.castVC.view];
    NSArray *cast = [[TheMovieDbFetcher castForMovieID:550] valueForKey:@"cast"];
    [self.castVC setCastArray:cast];
}

- (IBAction)addToCalendarClicked:(id)sender {
    [WLSTEventCreator addEventNamed:[NSString stringWithFormat:@"%@ release",self.movieTitle] description:[NSString stringWithFormat:@"Premiere of the movie \"%@\"",self.movieTitle] date:self.movieReleaseDate];
    NSString *notificationMessage = [NSString stringWithFormat:@"%@ release date: %@ was saved to your calendar", self.movieTitle, [self.movieReleaseDate descriptionWithCalendarFormat:@"%d.%m.%Y" timeZone:nil locale:nil]];
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


@end

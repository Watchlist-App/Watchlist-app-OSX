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

@interface MovieInfoViewController ()

@end

@implementation MovieInfoViewController

- (void)setMovie:(Movie *)movie{
    [self.posterView setImage:movie.posterPicture];
    [self.titleLabel setStringValue:movie.title];
    [self.releaseDateLabel setStringValue:[movie.releaseDate description]];
    [self.budgetLabel setStringValue:movie.budget.stringValue];
    [self.revenueLabel setStringValue:movie.revenue.stringValue];
    [self.runtimeLabel setStringValue:movie.runtime];
    [self.plotLabel setStringValue:movie.plot];
    [self.ratingLabel setFloatValue:movie.rating.floatValue];
    [self.youTubePlayerView.mainFrame loadHTMLString:[YouTubeFetcher youtubeHTMLForID:movie.youTubeTrailerID] baseURL:nil];
    
    SmallPostersViewController *smallPostersVC = [[SmallPostersViewController alloc] initWithNibName:@"MovieListViewController" bundle:[NSBundle mainBundle]];
    smallPostersVC.view.frame = self.similarMoviesView.frame;
    [self.view replaceSubview:self.similarMoviesView with:smallPostersVC.view];
    NSArray *list = [[TheMovieDbFetcher recommendationsForMovieID:movie.tmdbID.intValue] valueForKey:@"results"];
    [smallPostersVC setListArray:list];
    
    CastViewController *castVC = [[CastViewController alloc] initWithNibName:@"CastViewController" bundle:[NSBundle mainBundle]];
    castVC.view.frame = self.castView.frame;
    [self.view replaceSubview:self.castView with:castVC.view];
    NSArray *cast = [[TheMovieDbFetcher castForMovieID:movie.tmdbID.intValue] valueForKey:@"cast"];
    [castVC setCastArray:cast];
    
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
    
    
    SmallPostersViewController *smallPostersVC = [[SmallPostersViewController alloc] initWithNibName:@"MovieListViewController" bundle:[NSBundle mainBundle]];
    smallPostersVC.view.frame = self.similarMoviesView.frame;
    [self.view replaceSubview:self.similarMoviesView with:smallPostersVC.view];
    NSArray *list = [[TheMovieDbFetcher recommendationsForMovieID:550] valueForKey:@"results"];
    [smallPostersVC setListArray:list];
    
    CastViewController *castVC = [[CastViewController alloc] initWithNibName:@"CastViewController" bundle:[NSBundle mainBundle]];
    castVC.view.frame = self.castView.frame;
    [self.view replaceSubview:self.castView with:castVC.view];
    NSArray *cast = [[TheMovieDbFetcher castForMovieID:550] valueForKey:@"cast"];
    [castVC setCastArray:cast];
}

@end

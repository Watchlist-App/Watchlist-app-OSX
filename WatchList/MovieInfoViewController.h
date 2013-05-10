//
//  MovieInfoViewController.h
//  TheMovieDBTest
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Movie+TMDB.h"
#import <WebKit/WebKit.h>
#import "MovieInfoDelegate.h"


@interface MovieInfoViewController : NSViewController
@property (weak) IBOutlet NSImageView *posterView;
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *releaseDateLabel;
@property (weak) IBOutlet NSTextField *genresLabel;
@property (weak) IBOutlet NSTextField *countriesLabel;
@property (weak) IBOutlet NSTextField *budgetLabel;
@property (weak) IBOutlet NSTextField *revenueLabel;
@property (weak) IBOutlet NSTextField *runtimeLabel;
@property (weak) IBOutlet NSLevelIndicator *ratingLabel;
@property (weak) IBOutlet NSTextField *companiesLabel;
@property (weak) IBOutlet NSTextField *plotLabel;

@property (weak) IBOutlet NSView *castView;
@property (weak) IBOutlet NSView *similarMoviesView;
@property (weak) IBOutlet WebView *youTubePlayerView;

- (void)setMovie:(Movie *)movie;
- (void)setMovieDictionary:(NSDictionary *)movie;

@property (nonatomic, assign) id<MovieInfoDelegate> delegate;


@end

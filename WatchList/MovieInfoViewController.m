//
//  MovieInfoViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 02/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "MovieInfoViewController.h"
#import "TrailerViewController.h"
#import "TheMovieDbFetcher.h"
#import "MovieListViewController.h"

@interface MovieInfoViewController ()
@property (weak) IBOutlet NSImageView *posterImageView;
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *yearLabel;
@property (weak) IBOutlet NSTextField *studioLabel;
@property (weak) IBOutlet NSTextField *genreLabel;
@property (weak) IBOutlet NSTextField *runTimeLabel;
@property (weak) IBOutlet NSTextField *actorsLabel;
@property (weak) IBOutlet NSTextField *directorLabel;
@property (weak) IBOutlet NSTextField *producersLabel;
@property (weak) IBOutlet NSTextField *plotLabel;

@end

@implementation MovieInfoViewController

- (void)setMovie:(Movie *)movie{
    self.posterImageView.image = movie.posterPicture;
    self.titleLabel.stringValue = [movie.title description];
    self.yearLabel.stringValue = [movie.year.stringValue description];
    self.studioLabel.stringValue = @"NOPE";
    self.genreLabel.stringValue =  @"nope";//[movie.genre description];
    self.runTimeLabel.stringValue = @"NOPE";//[movie.runtime description];
    self.actorsLabel.stringValue = @"nope";//[movie.actors description];
    self.directorLabel.stringValue = @"nope";//[movie.directors description];
    self.producersLabel.stringValue = @"NOPE";
    self.plotLabel.stringValue = [movie.plot description];
    
    
    MovieListViewController *movieListVC = [[MovieListViewController alloc] initWithNibName:@"MovieListViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:movieListVC.view];
    NSArray *list = [[TheMovieDbFetcher recommendationsForMovieID:550] valueForKey:@"results"];
    [movieListVC setListArray:list];
    
}

- (IBAction)backButtonPressed:(id)sender {
    [self.delegate backToListPressed];
}

- (IBAction)trailerPressed:(id)sender {
    TrailerViewController *trailerVC = [[TrailerViewController alloc] initWithNibName:@"TrailerViewController" bundle:[NSBundle mainBundle]];
    trailerVC.view.frame = self.view.frame;
    [[self.view superview] replaceSubview:self.view with:trailerVC.view];
    [trailerVC setMovieTitle:[ self.titleLabel.stringValue stringByAppendingString:@" trailer"]];

    
}

@end

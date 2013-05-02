//
//  MovieInfoViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 02/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "MovieInfoViewController.h"

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
    self.titleLabel.stringValue = movie.title;
    self.yearLabel.stringValue = movie.year.stringValue;
    self.studioLabel.stringValue = @"NOPE";
    self.genreLabel.stringValue = movie.genre;
    self.runTimeLabel.stringValue = movie.runtime;
    self.actorsLabel.stringValue = movie.actors;
    self.directorLabel.stringValue = movie.directors;
    self.producersLabel.stringValue = @"NOPE";
    self.plotLabel.stringValue = movie.plot;
    
}

- (NSView *)viewForMovie:(Movie *)movie{
    [self setMovie:movie];
    return self.view;
    
}

@end

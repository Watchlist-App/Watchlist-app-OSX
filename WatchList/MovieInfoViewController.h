//
//  MovieInfoViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 02/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Movie+IMDB.h"

@class MovieInfoViewController;

@protocol MovieInfoDelegate <NSObject>
- (void)backToListPressed;
@end


@interface MovieInfoViewController : NSViewController
@property (nonatomic, assign) id<MovieInfoDelegate> delegate;
- (void)setMovie: (Movie *)movie;
@end

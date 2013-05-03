//
//  SearchViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SearchViewController;

@protocol SearchDelegate <NSObject>

- (void)selectedMovieWithID:(NSString *)imdbID;

@end


@interface SearchViewController : NSViewController

@property (nonatomic,assign) id<SearchDelegate> delegate;


- (void)searchForMovie:(NSString *)movieTitle;
- (NSArray *)searchResultsForMovie:(NSString *)movieTitle;

@end

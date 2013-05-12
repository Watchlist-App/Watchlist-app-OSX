//
//  SearchDelegate.h
//  WatchList
//
//  Created by Dmitry Mazuro on 04/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//


@protocol SearchDelegate <NSObject>
- (void)addToWatchlistMovieWithID:(NSString *)tmdbID;
- (void)addToFavoritesMovieWithID:(NSString *)tmdbID;
- (void)addToWatchedMovieWithID:(NSString *)tmdbID;
- (void)addToSelectedListMovieWithID:(NSString *)tmdbID;



@end

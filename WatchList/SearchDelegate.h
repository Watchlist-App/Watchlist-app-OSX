//
//  SearchDelegate.h
//  WatchList
//
//  Created by Dmitry Mazuro on 04/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//


@protocol SearchDelegate <NSObject>
- (void)selectedMovieWithID:(NSString *)tmdbID;
@end

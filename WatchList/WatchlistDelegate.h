//
//  WatchlistDelegate.h
//  WatchList
//
//  Created by Dmitry Mazuro on 04/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//
#import "Movie+TMDB.h"

@protocol WatchlistDelegate <NSObject>
-(void)clickedInfoForMovie:(Movie *)movie;
-(void)clickedRemoveMovie:(Movie *)movie;


@end

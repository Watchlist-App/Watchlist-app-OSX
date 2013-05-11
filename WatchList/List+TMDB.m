//
//  List+TMDB.m
//  WatchList
//
//  Created by Dmitry Mazuro on 11/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "List+TMDB.h"
#import "Movie+TMDB.h"
#import "TheMovieDbFetcher.h"

@implementation List (TMDB)
- (void)addMovieWithID:(NSUInteger)ID{
        NSDictionary *tmdbDictionary = [TheMovieDbFetcher infoForMovieID:ID];
        Movie *movie = [Movie movieWithTMDBDictionary:tmdbDictionary inManagedObjectContext:self.managedObjectContext];
        [self addMoviesObject:movie];
}
@end

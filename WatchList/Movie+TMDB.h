//
//  Movie+TMDB.h
//  WatchList
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "Movie.h"

@interface Movie (TMDB)
+ (Movie *)movieWithTMDBDictionary:(NSDictionary *)tmdbDictiory inManagedObjectContext:(NSManagedObjectContext *)context;

@end

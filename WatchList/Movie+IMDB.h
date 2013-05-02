//
//  Movie+IMDB.h
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "Movie.h"
#import "List+Create.h"

@interface Movie (IMDB)

+ (Movie *)movieWithIMDBDictionary:(NSDictionary *)imdbDictiory inManagedObjectContext:(NSManagedObjectContext *)context;
+ (Movie *)movieWithIMDBDictionary:(NSDictionary *)imdbDictiory forList:(List *)list inManagedObjectContext:(NSManagedObjectContext *)context;


@end

//
//  Movie+IMDB.m
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "Movie+IMDB.h"
#import "List+Create.h"

@implementation Movie (IMDB)

+ (Movie *)movieWithIMDBDictionary:(NSDictionary *)imdbDictiory inManagedObjectContext:(NSManagedObjectContext *)context{
    Movie *movie = nil;
        
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    //request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
        
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    if (!matches || ([matches count] > 1)) {  // nil means fetch failed; more than one impossible (unique!)
        // handle error
    } else if (![matches count]) { // none found, so let's create a Photo for that Flickr photo
        movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
        movie.title = [imdbDictiory valueForKey:@"title"];
        movie.year = [imdbDictiory valueForKey:@"year"];
        
    } else { // found the Photo, just return it from the list of matches (which there will only be one of)
        movie = [matches lastObject];
    }
    
    return movie;

}

+ (Movie *)movieWithIMDBDictionary:(NSDictionary *)imdbDictiory forList:(List *)list inManagedObjectContext:(NSManagedObjectContext *)context{
    Movie *movie = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    //request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    if (!matches || ([matches count] > 1)) {  // nil means fetch failed; more than one impossible (unique!)
        // handle error
    } else if (![matches count]) { // none found, so let's create a Photo for that Flickr photo
        movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
        movie.title = [imdbDictiory valueForKey:@"title"];
        movie.year = [imdbDictiory valueForKey:@"year"];
        movie.listContainer = list;
        
    } else { // found the Photo, just return it from the list of matches (which there will only be one of)
        movie = [matches lastObject];
    }
    
    return movie;
    
}

@end

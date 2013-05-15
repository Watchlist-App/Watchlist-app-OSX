//
//  Movie+TMDB.m
//  WatchList
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "Movie+TMDB.h"
#import "TheMovieDbFetcher.h"

@implementation Movie (TMDB)
+ (Movie *)movieWithTMDBDictionary:(NSDictionary *)tmdbDictiory inManagedObjectContext:(NSManagedObjectContext *)context{
    Movie *movie = nil;
    NSLog(@"inserting movie");
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    request.predicate = [NSPredicate predicateWithFormat:@"tmdbID == %@", [tmdbDictiory valueForKey:@"id"]];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    
    if (!matches || ([matches count] > 1)) {  // nil means fetch failed; more than one impossible (unique!)
        // handle error
    } else if (![matches count]) {
        NSLog(@"creating movie");
        movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
        movie.title = [tmdbDictiory valueForKey:@"title"];
        movie.releaseDate = [NSDate dateWithNaturalLanguageString:[tmdbDictiory valueForKey:@"release_date"]];
        movie.rating = [tmdbDictiory valueForKey:@"vote_average"];
        movie.plot = [tmdbDictiory valueForKey:@"overview"];
        movie.tmdbID = [tmdbDictiory valueForKey:@"id"];
        movie.posterURL = [tmdbDictiory valueForKey:@"poster_path"];
        movie.runtime = [[tmdbDictiory valueForKey:@"runtime"] stringValue];
        movie.budget = [tmdbDictiory valueForKey:@"budget"];
        movie.revenue = [tmdbDictiory valueForKey:@"revenue"];
        movie.website = [tmdbDictiory valueForKey:@"homepage"];
        
        NSArray *countries = [tmdbDictiory valueForKey:@"production_countries"];
        NSArray *studios = [tmdbDictiory valueForKey:@"production_companies"];
        NSArray *genres = [tmdbDictiory valueForKey:@"genres"];
        
        __block NSString *countriesString = [[NSString alloc] init];
        [countries enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            countriesString = [countriesString stringByAppendingFormat:@"%@ ",[object valueForKey:@"name"]];
        }];
    
       
        
        movie.countries = countriesString;
        
        __block NSString *studiosString = [[NSString alloc] init];
        [studios enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            studiosString = [studiosString stringByAppendingFormat:@"%@ ",[object valueForKey:@"name"]];
        }];
        
      
        movie.productionCompanies = studiosString;
        
        __block NSString *genresString = [[NSString alloc] init];
        [genres enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            genresString = [genresString stringByAppendingFormat:@"%@ ",[object valueForKey:@"name"]];
        }];
        
      
        movie.genres = genresString;
        
        NSArray *youTubeTrailers = [[TheMovieDbFetcher trailersForMovieID:movie.tmdbID.intValue] valueForKey:@"youtube"];
        if (youTubeTrailers.count > 0) {
            movie.youTubeTrailerID = [youTubeTrailers[0] valueForKey:@"source"];
        }
        
        NSImage *poster = [TheMovieDbFetcher imageWithPath:[tmdbDictiory valueForKey:@"poster_path" ] size:@"w500"];//[TheMovieDbFetcher posterForMovieID:movie.tmdbID.intValue size:@"w500"];
    
        movie.posterPicture = poster;
        
        
    } else {
        movie = [matches lastObject];
    }
    
    return movie;
    
}
@end

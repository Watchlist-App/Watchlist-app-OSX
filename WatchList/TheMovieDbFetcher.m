//
//  TheMovieDbFetcher.m
//  WatchList
//
//  Created by Dmitry Mazuro on 09/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "TheMovieDbFetcher.h"

@interface TheMovieDbFetcher ()
+ (NSDictionary *)executeTheMovieDbFetch:(NSString *)query;
+ (NSString *)baseURL;
+ (NSURL *)urlForQuery:(NSString *)query complex:(BOOL)complex;

@end

@implementation TheMovieDbFetcher


+ (NSURL *)urlForQuery:(NSString *)query complex:(BOOL)complex{
    if (complex) {
        query = [NSString stringWithFormat:@"http://api.themoviedb.org/3/%@&api_key=%@",query,TheMovieDbAPIKey];
    } else{
        query = [NSString stringWithFormat:@"http://api.themoviedb.org/3/%@?api_key=%@",query,TheMovieDbAPIKey];
    }
    NSLog(@"%@",query);
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:query];
}

+ (NSDictionary *)executeTheMovieDbFetch:(NSString *)query{
    
    NSURL *queryURL;
    if ([query hasPrefix:@"search/"]) {
        queryURL = [self urlForQuery:query complex:YES];
    } else{
        queryURL = [self urlForQuery:query complex:NO];
    }
    
    NSData *jsonData = [NSData dataWithContentsOfURL:queryURL];
    if (!jsonData) {
        return @{@"error": @"404"};
    }
    NSError *error = nil;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
        return @{@"error": @"404"};
        
    }
    NSLog([results description]);
    return results;
}


+ (NSImage *)imageWithPath:(NSString *)path size:(NSString *)size{
    NSString *baseUrl = @"http://d3gtl9l2a4fn1j.cloudfront.net/t/p/";
    //NSString *baseUrl = [self baseURL];
    NSString *imageURL = [NSString stringWithFormat:@"%@%@%@",baseUrl, size, path];
    NSLog(@"%@",imageURL);
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    if (imageData) {
        return [[NSImage alloc] initWithData:imageData];
    } else{
        return [NSImage imageNamed:@"NSUser"];
    }

}

+ (NSDictionary *)infoForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)infoForCompanyID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"company/%lu",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)moviesForCompanyID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"company/%lu/movies",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)infoForPersonID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"person/%lu",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)creditsForPersonID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"person/%lu/credits",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)imagesForPersonID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"person/%lu/images",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)changesForPersonID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"person/%lu/changes",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)trailersForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/trailers",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)imagesForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/images",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)keywordsForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/keywords",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}


+ (NSDictionary *)castForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/casts",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)releaseDatesForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/releases",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)recommendationsForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/similar_movies",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)listsForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/lists",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)changesForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/changes",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)translationsForMovieID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"movie/%lu/translations",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)popularMovies{
    NSString *query = [NSString stringWithFormat:@"movie/popular"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)popularPersons{
    NSString *query = [NSString stringWithFormat:@"person/popular"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)latestMovie{
    NSString *query = [NSString stringWithFormat:@"movie/latest"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)latestPerson{
    NSString *query = [NSString stringWithFormat:@"person/latest"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)upcomingMovies{
    NSString *query = [NSString stringWithFormat:@"movie/upcoming"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)topRatedMovies{
    NSString *query = [NSString stringWithFormat:@"movie/top_rated"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)nowPlayingMovies{
    NSString *query = [NSString stringWithFormat:@"movie/now_playing"];
    return [self executeTheMovieDbFetch:query];
}


+ (NSString *)baseURL{
    return [[self executeTheMovieDbFetch:@"configuration"] valueForKeyPath:@"images.base_url"];
}

+ (NSDictionary *)genresList{
    NSString *query = [NSString stringWithFormat:@"genre/list"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)moviesForGenreID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"genre/%lu/movies",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)moviesForKeywordID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"keyword/%lu/movies",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)infoForKeywordID:(NSUInteger)ID{
    NSString *query = [NSString stringWithFormat:@"keyword/%lu",(unsigned long)ID];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)changedMoviesIDs{
    NSString *query = [NSString stringWithFormat:@"movie/changes"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)changedPeopleIDs{
    NSString *query = [NSString stringWithFormat:@"person/changes"];
    return [self executeTheMovieDbFetch:query];
}

+ (NSImage *)posterForMovieID:(NSUInteger)ID size:(NSString *)size{
    NSArray *posterPaths = [[self imagesForMovieID:ID] valueForKey:@"posters"];
    if (posterPaths.count) {
        return [self imageWithPath:[posterPaths[0] valueForKey:@"file_path"] size:size];
    }
    else return [NSImage imageNamed:@"NSUser"];
}


+ (NSImage *)backDropForMovieID:(NSUInteger)ID size:(NSString *)size{
    NSArray *backdropsPaths = [[self imagesForMovieID:ID] valueForKey:@"backdrops"];
    if (backdropsPaths.count) {
        return [self imageWithPath:[backdropsPaths[0] valueForKey:@"file_path"] size:size];
    }
    else return [NSImage imageNamed:@"NSUser"];
}

+ (NSDictionary *)searchMoviesByTitle:(NSString *)title{
    NSString *query = [NSString stringWithFormat:@"search/movie?query=%@",title];
    return [self executeTheMovieDbFetch:query];
    
}

+ (NSDictionary *)searchCompanyByName:(NSString *)name{
    NSString *query = [NSString stringWithFormat:@"search/company?query=%@",name];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)searchPeopleByName:(NSString *)name{
    NSString *query = [NSString stringWithFormat:@"search/person?query=%@",name];
    return [self executeTheMovieDbFetch:query];
}

+ (NSDictionary *)searchKeywordsByName:(NSString *)name{
    NSString *query = [NSString stringWithFormat:@"search/keyword?query=%@",name];
    return [self executeTheMovieDbFetch:query];
}
@end

//
//  TheMovieDbFetcher.h
//  WatchList
//
//  Created by Dmitry Mazuro on 09/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheMovieDbApiKey.h"

@interface TheMovieDbFetcher : NSObject
//movies
+ (NSDictionary *)infoForMovieID:(NSUInteger)ID;
+ (NSDictionary *)castForMovieID:(NSUInteger)ID;
+ (NSDictionary *)imagesForMovieID:(NSUInteger)ID;
+ (NSDictionary *)keywordsForMovieID:(NSUInteger)ID;
+ (NSDictionary *)releaseDatesForMovieID:(NSUInteger)ID;
+ (NSDictionary *)trailersForMovieID:(NSUInteger)ID;
+ (NSDictionary *)translationsForMovieID:(NSUInteger)ID;
+ (NSDictionary *)recommendationsForMovieID:(NSUInteger)ID;
+ (NSDictionary *)listsForMovieID:(NSUInteger)ID;
+ (NSDictionary *)changesForMovieID:(NSUInteger)ID;
+ (NSDictionary *)latestMovie;
+ (NSDictionary *)upcomingMovies;
+ (NSDictionary *)nowPlayingMovies;
+ (NSDictionary *)popularMovies;
+ (NSDictionary *)topRatedMovies;

//people
+ (NSDictionary *)infoForPersonID:(NSUInteger)ID;
+ (NSDictionary *)creditsForPersonID:(NSUInteger)ID;
+ (NSDictionary *)imagesForPersonID:(NSUInteger)ID;
+ (NSDictionary *)changesForPersonID:(NSUInteger)ID;
+ (NSDictionary *)popularPersons;
+ (NSDictionary *)latestPerson;

//companies
+ (NSDictionary *)infoForCompanyID:(NSUInteger)ID;
+ (NSDictionary *)moviesForCompanyID:(NSUInteger)ID;

//genres
+ (NSDictionary *)genresList;
+ (NSDictionary *)moviesForGenreID:(NSUInteger)ID;

//keywords
+ (NSDictionary *)infoForKeywordID:(NSUInteger)ID;
+ (NSDictionary *)moviesForKeywordID:(NSUInteger)ID;

//search
+ (NSDictionary *)searchMoviesByTitle:(NSString *)title;
+ (NSDictionary *)searchPeopleByName:(NSString *)name;
+ (NSDictionary *)searchCompanyByName:(NSString *)name;
+ (NSDictionary *)searchKeywordsByName:(NSString *)name;

//changes
+ (NSDictionary *)changedMoviesIDs;
+ (NSDictionary *)changedPeopleIDs;

//images
+ (NSImage *)imageWithPath:(NSString *)path size:(NSString *)size;
+ (NSImage *)backDropForMovieID:(NSUInteger)ID size:(NSString *)size;
+ (NSImage *)posterForMovieID:(NSUInteger)ID size:(NSString *)size;


@end

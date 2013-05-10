//
//  List.h
//  WatchList
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Movie, User;

@interface List : NSManagedObject

@property (nonatomic, retain) id icon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *movies;
@property (nonatomic, retain) User *listOwner;
@property (nonatomic, retain) User *favsOwner;
@property (nonatomic, retain) User *watchlistOwner;
@property (nonatomic, retain) User *watchedOwner;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addMoviesObject:(Movie *)value;
- (void)removeMoviesObject:(Movie *)value;
- (void)addMovies:(NSSet *)values;
- (void)removeMovies:(NSSet *)values;

@end

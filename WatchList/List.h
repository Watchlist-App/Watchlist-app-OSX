//
//  List.h
//  WatchList
//
//  Created by Dmitry Mazuro on 29/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface List : NSManagedObject

@property (nonatomic, retain) id icon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *movies;
@property (nonatomic, retain) NSManagedObject *owner;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addMoviesObject:(NSManagedObject *)value;
- (void)removeMoviesObject:(NSManagedObject *)value;
- (void)addMovies:(NSSet *)values;
- (void)removeMovies:(NSSet *)values;

@end

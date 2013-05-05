//
//  Movie.h
//  WatchList
//
//  Created by Dmitry Mazuro on 05/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * actors;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * directors;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * imdbID;
@property (nonatomic, retain) NSString * imdbURL;
@property (nonatomic, retain) NSString * plot;
@property (nonatomic, retain) id posterPicture;
@property (nonatomic, retain) NSString * posterURL;
@property (nonatomic, retain) NSDecimalNumber * rating;
@property (nonatomic, retain) NSString * runtime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDecimalNumber * year;
@property (nonatomic, retain) NSSet *listContainer;
@end

@interface Movie (CoreDataGeneratedAccessors)

- (void)addListContainerObject:(List *)value;
- (void)removeListContainerObject:(List *)value;
- (void)addListContainer:(NSSet *)values;
- (void)removeListContainer:(NSSet *)values;

@end

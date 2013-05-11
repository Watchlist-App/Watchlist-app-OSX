//
//  Movie.h
//  WatchList
//
//  Created by Dmitry Mazuro on 11/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Movie : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * budget;
@property (nonatomic, retain) NSString * countries;
@property (nonatomic, retain) NSString * genres;
@property (nonatomic, retain) NSString * plot;
@property (nonatomic, retain) id posterPicture;
@property (nonatomic, retain) NSString * posterURL;
@property (nonatomic, retain) NSString * productionCompanies;
@property (nonatomic, retain) NSDecimalNumber * rating;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSDecimalNumber * revenue;
@property (nonatomic, retain) NSString * runtime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * tmdbID;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * youTubeTrailerID;
@property (nonatomic, retain) NSSet *listContainers;
@end

@interface Movie (CoreDataGeneratedAccessors)

- (void)addListContainersObject:(List *)value;
- (void)removeListContainersObject:(List *)value;
- (void)addListContainers:(NSSet *)values;
- (void)removeListContainers:(NSSet *)values;

@end

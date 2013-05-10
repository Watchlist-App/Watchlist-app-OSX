//
//  User.h
//  WatchList
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) id profilePicture;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSSet *lists;
@property (nonatomic, retain) List *favourites;
@property (nonatomic, retain) List *watchlist;
@property (nonatomic, retain) List *watchedMovies;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addListsObject:(List *)value;
- (void)removeListsObject:(List *)value;
- (void)addLists:(NSSet *)values;
- (void)removeLists:(NSSet *)values;

@end

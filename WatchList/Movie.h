//
//  Movie.h
//  WatchList
//
//  Created by Dmitry Mazuro on 29/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * posterURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDecimalNumber * year;
@property (nonatomic, retain) id posterPicture;
@property (nonatomic, retain) List *listContainer;

@end

//
//  List+Create.h
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "List.h"
#import "User+Create.h"

@interface List (Create)
+ (List *)listWithTitle:(NSString *)title inManagedObjectContext:(NSManagedObjectContext *)context;
+ (List *)listWithTitle:(NSString *)title forUser:(User *)user inManagedObjectContext:(NSManagedObjectContext *)context;

@end

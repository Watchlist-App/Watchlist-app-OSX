//
//  User+Create.h
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "User.h"

@interface User (Create)
+ (User *)userWithLogin: (NSString *)login inManagedObjectContext:(NSManagedObjectContext*) context;
@end

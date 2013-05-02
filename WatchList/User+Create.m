//
//  User+Create.m
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)
+ (User *)userWithLogin:(NSString *)login inManagedObjectContext:(NSManagedObjectContext *)context{
    User *user = nil;
    
    // This is just like Photo(Flickr)'s method.  Look there for commentary.
    
    if (login.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"login"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"login = %@", login];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
            user.login = login;
        } else {
            user = [matches lastObject];
        }
    }
    
    return user;
}
@end

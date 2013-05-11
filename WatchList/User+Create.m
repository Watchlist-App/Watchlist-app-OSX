//
//  User+Create.m
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "User+Create.h"
#import "List+Create.h"


@implementation User (Create)
+ (User *)userWithLogin:(NSString *)login password:(NSString *)password profilePicture:(NSImage *)picture inManagedObjectContext:(NSManagedObjectContext *)context{
    User *user = nil;
        
    if (login.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"login"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"login == %@", login];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
            user.login = login;
            user.password = password;
            user.profilePicture = picture;
            
            List *favorites = [List ListWithTitle:@"Favorites" icon:[NSImage imageNamed:@"star.png"] forUser:user inManagedObjectContext:context];
            List *watchlist = [List ListWithTitle:@"Watchlist" icon:[NSImage imageNamed:@"list.png"] forUser:user inManagedObjectContext:context];
            List *watchedMovies = [List ListWithTitle:@"Watched movies" icon:[NSImage imageNamed:@"check.png"] forUser:user inManagedObjectContext:context];
            
        } else {
            user = [matches lastObject];
        }
    }
    
    return user;
}
@end

//
//  List+Create.m
//  WatchList
//
//  Created by Dmitry Mazuro on 01/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "List+Create.h"

@implementation List (Create)

+ (List *)listWithTitle:(NSString *)title inManagedObjectContext:(NSManagedObjectContext *)context{
    List *list = nil;
    
    
    if (title.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"List"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:context];
            list.title = title;
        } else {
            list = [matches lastObject];
        }
    }
    
    return list;
}

+ (List *)listWithTitle:(NSString *)title forUser:(User *)user inManagedObjectContext:(NSManagedObjectContext *)context{
    List *list = nil;
    
    if (title.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"List"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                  ascending:YES
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:context];
            list.title = title;
            list.owner = user;
        } else {
            list = [matches lastObject];
        }
    }
    
    return list;

}
@end

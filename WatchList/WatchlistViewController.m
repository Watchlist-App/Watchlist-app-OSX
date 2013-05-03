//
//  WatchlistViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WatchlistViewController.h"

@interface WatchlistViewController ()
@end

@implementation WatchlistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = context;
    }
    
    return self;
}

- (id)initInContext:(NSManagedObjectContext *)context{
    self = [super initWithNibName:@"WatchlistViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.managedObjectContext = context;
    }
    
    return self;
}

@end

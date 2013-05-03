//
//  PostersViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "PostersViewController.h"

@interface PostersViewController ()
@property (weak) IBOutlet NSScrollView *postersScrollView;

@end

@implementation PostersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = context;
    }
    
    return self;
}

- (id)initInContext:(NSManagedObjectContext *)context{
    self = [super initWithNibName:@"PostersViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.managedObjectContext = context;

    }
    
    return self;
}

- (void)setBackgroundImageNamed:(NSString *)imageName{
    self.postersScrollView.backgroundColor = [NSColor colorWithPatternImage:[NSImage imageNamed:imageName]];
}

@end

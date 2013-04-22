//
//  WLSTAppDelegate.h
//  WatchList
//
//  Created by Dmitry Mazuro on 09/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoginWindowController.h"
#import "WatchlistWindowController.h"

@interface WLSTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)saveAction:(id)sender;
@property (strong, nonatomic)LoginWindowController* loginWindowController;
@property (strong, nonatomic)WatchlistWindowController *watchlistWindowController;
@end

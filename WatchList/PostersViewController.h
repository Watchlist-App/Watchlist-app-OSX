//
//  PostersViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Movie+IMDB.h"
@class PostersViewController;


@protocol PostersCollectionViewDelegate <NSObject>
-(void) infoForMovie:(Movie *)movie;
@end


@interface PostersViewController : NSViewController

@property (nonatomic, assign) id <PostersCollectionViewDelegate> delegate;
@property (strong) NSManagedObjectContext *managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inContext:(NSManagedObjectContext *)context;
- (id)initInContext:(NSManagedObjectContext *)context;
- (void)setBackgroundImageNamed:(NSString *)imageName;

@end

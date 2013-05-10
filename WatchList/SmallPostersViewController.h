//
//  MovieListViewController.h
//  TheMovieDBTest
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SmallPostersViewController : NSViewController
@property (strong) IBOutlet NSArrayController *listAC;
- (void)setListArray:(NSArray *)list;

@end

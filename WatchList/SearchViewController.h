//
//  SearchViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SearchViewController : NSViewController
- (void)searchForMovie:(NSString *)movieTitle;
- (NSArray *)searchResultsForMovie:(NSString *)movieTitle;

@end

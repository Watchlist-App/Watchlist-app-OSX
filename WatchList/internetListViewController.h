//
//  SearchViewController.h
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SearchDelegate.h"

@interface internetListViewController : NSViewController

@property (nonatomic,assign) id<SearchDelegate> delegate;

- (void)setListDictionary:(NSDictionary *)list;

@end

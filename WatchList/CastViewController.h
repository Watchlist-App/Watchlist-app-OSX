//
//  CastViewController.h
//  TheMovieDBTest
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CastViewController : NSViewController
@property (strong) IBOutlet NSArrayController *castAc;
- (void)setCastArray:(NSArray *)cast;
@end

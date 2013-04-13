//
//  TransparentCell.m
//  WatchList
//
//  Created by Dmitry Mazuro on 09/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "TransparentCell.h"

@implementation TransparentCell

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self 
    }
    
    return self;
}

- (BOOL)isOpaque {
    
    return NO;
}

@end

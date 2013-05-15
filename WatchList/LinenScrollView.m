//
//  LinenScrollView.m
//  WatchList
//
//  Created by Dmitry Mazuro on 12/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "LinenScrollView.h"

@implementation LinenScrollView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"linen"]] set];
    [NSBezierPath fillRect:bounds];
}

@end

//
//  WhiteView.m
//  WatchList
//
//  Created by Dmitry Mazuro on 05/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "WhiteView.h"

@implementation WhiteView

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
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"maze"]] set];
    [NSBezierPath fillRect:bounds];

}

@end

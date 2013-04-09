//
//  LoginView.m
//  UniversalLoginWindow
//
//  Created by Dmitry Mazuro on 02/03/2013.
//  Copyright (c) 2013 Dmitry Mazuro. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)drawRect:(NSRect)dirtyRect{
    NSRect bounds = [self bounds];
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"maze"]] set];
    [NSBezierPath fillRect:bounds];
}

@end

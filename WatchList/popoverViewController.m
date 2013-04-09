//
//  popoverViewController.m
//  UniversalLoginWindow
//
//  Created by Dmitry Mazuro on 07/03/2013.
//  Copyright (c) 2013 Dmitry Mazuro. All rights reserved.
//

#import "popoverViewController.h"

@interface popoverViewController ()

@end

@implementation popoverViewController

- (NSPopover *)popover{
    if (!_popover) {
        _popover = [[NSPopover alloc] init];
    }
    return _popover;
}

- (void)showRelativeToRect:(NSRect)positioningRect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge title:(NSString *)title text:(NSString *)text{
    self.popoverText.stringValue = text;
    self.popoverTitle.stringValue = title;
    [self.popover showRelativeToRect:positioningRect ofView:positioningView preferredEdge:preferredEdge];
}

- (void)showRelativeToView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge title:(NSString *)title text:(NSString *)text{
    self.popoverText.stringValue = text;
    self.popoverTitle.stringValue = title;
    [self.popover showRelativeToRect:positioningView.bounds ofView:positioningView preferredEdge:NSMaxXEdge];
}
@end

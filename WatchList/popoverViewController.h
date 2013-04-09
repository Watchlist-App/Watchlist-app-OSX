//
//  popoverViewController.h
//  UniversalLoginWindow
//
//  Created by Dmitry Mazuro on 07/03/2013.
//  Copyright (c) 2013 Dmitry Mazuro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface popoverViewController : NSViewController
@property (strong, nonatomic) IBOutlet NSPopover *popover;
@property (weak) IBOutlet NSTextField *popoverTitle;
@property (weak) IBOutlet NSTextField *popoverText;
- (void)showRelativeToRect:(NSRect)positioningRect ofView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge title:(NSString *)title text:(NSString*) text;
- (void)showRelativeToView:(NSView *)positioningView preferredEdge:(NSRectEdge)preferredEdge title:(NSString *)title text:(NSString*) text;
@end

//
//  PostersCollectionView.m
//  WatchList
//
//  Created by Dmitry Mazuro on 05/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "PostersCollectionView.h"



@implementation PostersCollectionView

- (void)magnifyWithEvent:(NSEvent *)event{
    CGFloat newWidth = self.minItemSize.width * ( event.magnification + 1.0 );
    CGFloat newHeight = self.minItemSize.height * ( event.magnification + 1.0 );

    if (newWidth < 150) {
        newWidth = 150;
    }
    
    if (newWidth > 600) {
        newWidth = 600;
    }
    
    newHeight = newWidth * 3/2;
    
    NSSize newSize = NSSizeFromCGSize(CGSizeMake(newWidth, newHeight));
    [self setMinItemSize:newSize];
    [self setMaxItemSize:newSize];
}

@end

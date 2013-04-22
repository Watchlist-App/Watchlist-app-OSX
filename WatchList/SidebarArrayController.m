//
//  SidebarArrayController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 09/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "SidebarArrayController.h"

@implementation SidebarArrayController

-(id)newObject{
    NSImage *image = [NSImage imageNamed:@"constanza.jpg"];
    id newObj = [super newObject];
    int a = rand()%100;
    NSString *title;
    title = [NSString stringWithFormat:@"lel, %d",a];
    [newObj setValue:title forKey:@"title"];
    [newObj setValue:image forKey:@"icon"];
    return newObj;
    
}

@end
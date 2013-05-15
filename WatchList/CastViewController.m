//
//  CastViewController.m
//  TheMovieDBTest
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "CastViewController.h"
#import "TheMovieDbFetcher.h"

@interface CastViewController ()

@end

@implementation CastViewController

- (void)setCastArray:(NSArray *)cast{
    self.castAc.content = cast;
    dispatch_queue_t photoFetchQueue = dispatch_queue_create("Photos fetch", NULL);
    dispatch_async(photoFetchQueue, ^{
        [self.castAc.content enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
            [obj setValue:[TheMovieDbFetcher imageWithPath:[obj valueForKey:@"profile_path"] size:@"w185"] forKey:@"photo"];
        }];
    });
}
@end

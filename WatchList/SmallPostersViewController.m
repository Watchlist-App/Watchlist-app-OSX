//
//  MovieListViewController.m
//  TheMovieDBTest
//
//  Created by Dmitry Mazuro on 10/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "SmallPostersViewController.h"
#import "TheMovieDbFetcher.h"

@interface SmallPostersViewController ()

@end

@implementation SmallPostersViewController

- (void)setListArray:(NSArray *)list{
    self.listAC.content = list;
    dispatch_queue_t posterImagesQueue = dispatch_queue_create("Poster images fetch", NULL);
    dispatch_async(posterImagesQueue, ^{
        [self.listAC.content enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
            [obj setValue:[TheMovieDbFetcher imageWithPath:[obj valueForKey:@"poster_path"] size:@"w154"] forKey:@"poster"];
        }];
    });
}

@end

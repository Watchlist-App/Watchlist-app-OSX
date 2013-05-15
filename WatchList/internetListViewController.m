//
//  SearchViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "internetListViewController.h"
#import "TheMovieDbFetcher.h"

@interface internetListViewController ()
@property (strong) IBOutlet NSArrayController *listArrayController;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSTableView *listTable;
@property BOOL isNotReady;

- (IBAction)addButtonClicked:(id)sender;
- (IBAction)addToFavouritesClicked:(id)sender;
- (IBAction)addToWatchlistClicked:(id)sender;
- (IBAction)addToWatchedMovesClicked:(id)sender;


@end

@implementation internetListViewController


- (void)setListDictionary:(NSDictionary *)list{
    [self.progressIndicator setFrameOrigin: CGPointMake((self.listTable.frame.origin.x + (self.listTable.frame.size.width / 2)),
                                                      (self.listTable.frame.origin.y + (self.listTable.frame.size.height / 2)))];
    [self.progressIndicator startAnimation:self];
  
    self.isNotReady = YES;
    self.listArrayController.content = [list valueForKey:@"results"];
    dispatch_queue_t fetchQueue = dispatch_queue_create("TMDB Fetch", NULL);
    dispatch_async(fetchQueue, ^{
        [self.listArrayController.content enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            [object setValue:[TheMovieDbFetcher imageWithPath:[object valueForKey:@"poster_path"] size:@"w154"] forKey:@"posterPicture"];
            [object setValue:[NSDate dateWithNaturalLanguageString:[object valueForKey:@"release_date"]] forKey:@"releaseDate"];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isNotReady = NO;
            [self.listTable reloadData];
            [self.progressIndicator stopAnimation:self];
        });
    });


}


- (IBAction)addButtonClicked:(id)sender {
    NSUInteger index = [self.listTable rowForView:sender];
    NSString *tmdbID = [[self.listArrayController.content objectAtIndex:index] valueForKey:@"id"];
    [self.listArrayController removeObjectAtArrangedObjectIndex:index];
    [self.delegate addToSelectedListMovieWithID: tmdbID];

}

- (IBAction)addToWatchlistClicked:(id)sender {
    NSUInteger index = [self.listTable rowForView:sender];
    NSString *tmdbID = [[self.listArrayController.content objectAtIndex:index] valueForKey:@"id"];
    [self.listArrayController removeObjectAtArrangedObjectIndex:index];
    [self.delegate addToWatchlistMovieWithID: tmdbID];
    
}

- (IBAction)addToFavouritesClicked:(id)sender {
    NSUInteger index = [self.listTable rowForView:sender];
    NSString *tmdbID = [[self.listArrayController.content objectAtIndex:index] valueForKey:@"id"];
    [self.listArrayController removeObjectAtArrangedObjectIndex:index];
    [self.delegate addToFavoritesMovieWithID: tmdbID];
    
}

- (IBAction)addToWatchedMovesClicked:(id)sender {
    NSUInteger index = [self.listTable rowForView:sender];
    NSString *tmdbID = [[self.listArrayController.content objectAtIndex:index] valueForKey:@"id"];
    [self.listArrayController removeObjectAtArrangedObjectIndex:index];
    [self.delegate addToWatchedMovieWithID: tmdbID];
    
}


@end

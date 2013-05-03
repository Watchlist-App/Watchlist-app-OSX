//
//  SearchViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 03/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "SearchViewController.h"
#import "IMDBFetcher.h"

@interface SearchViewController ()
@property (strong) IBOutlet NSArrayController *searchResultsArrayController;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSTableView *searchResultsTable;


@end

@implementation SearchViewController


- (void)searchForMovie:(NSString *)movieTitle{
    [self.searchResultsTable setHidden:YES];
    [self.progressIndicator startAnimation:self];
    dispatch_queue_t fetchQueue = dispatch_queue_create("IMDB Fetch", NULL);
    dispatch_async(fetchQueue, ^{
        self.searchResultsArrayController.content = [IMDBFetcher searchMoviesByTitle:movieTitle];
        [self.searchResultsArrayController.content enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            NSURL *imageURL = [NSURL URLWithString:[object valueForKey:@"poster"]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            NSImage *posterImage;
            if (imageData) {
                posterImage = [[NSImage alloc] initWithData:imageData];
            } else{
                posterImage = [NSImage imageNamed:@"NSUser"];
            }
            
            [object setValue:posterImage forKey:@"posterPicture"];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressIndicator stopAnimation:self];
            [self.searchResultsTable setHidden:NO];

        });
    });

}

- (IBAction)addButtonPressed:(id)sender {
    NSUInteger index = [self.searchResultsTable rowForView:sender];
    NSString *imdbID = [[self.searchResultsArrayController.content objectAtIndex:index] valueForKey:@"imdb_id"];
    [self.delegate selectedMovieWithID: imdbID];

}


- (NSArray *)searchResultsForMovie:(NSString *)movieTitle{
    [self.searchResultsTable setHidden:YES];
    [self.progressIndicator startAnimation:self];
    dispatch_queue_t fetchQueue = dispatch_queue_create("IMDB Fetch", NULL);
    dispatch_async(fetchQueue, ^{
        self.searchResultsArrayController.content = [IMDBFetcher searchMoviesByTitle:movieTitle];
        [self.searchResultsArrayController.content enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
            NSURL *imageURL = [NSURL URLWithString:[object valueForKey:@"poster"]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            NSImage *posterImage;
            if (imageData) {
                posterImage = [[NSImage alloc] initWithData:imageData];
            } else{
                posterImage = [NSImage imageNamed:@"NSUser"];
            }
            
            [object setValue:posterImage forKey:@"posterPicture"];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressIndicator stopAnimation:self];
            [self.searchResultsTable setHidden:NO];
            
        });
    });
    return self.searchResultsArrayController.content;

}


@end

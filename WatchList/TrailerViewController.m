//
//  TrailerViewController.m
//  WatchList
//
//  Created by Dmitry Mazuro on 05/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>
#import "YouTubeFetcher.h"

@interface TrailerViewController ()
@property (strong) IBOutlet WebView *webView;

@end

@implementation TrailerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setMovieTitle:(NSString *)title{
    [self.webView.mainFrame loadHTMLString:[YouTubeFetcher youtubeHTMLForTitle:title] baseURL:nil];
}

@end

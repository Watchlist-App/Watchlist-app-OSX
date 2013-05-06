//
//  YouTubeFetcher.h
//  WatchList
//
//  Created by Dmitry Mazuro on 05/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouTubeFetcher : NSObject
+ (NSString *)videoURLForTitle:(NSString *)title;
+ (NSString *)videoIDForTitle:(NSString *)title;
+ (NSString *)youtubeIframeForTitle:(NSString *)url;
+ (NSString *)youtubeIframeForID:(NSString *)ID;
+ (NSString *)youtubeHTMLForTitle:(NSString *)title;
@end

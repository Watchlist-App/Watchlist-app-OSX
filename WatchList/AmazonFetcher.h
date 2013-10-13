//
//  AmazonFetcher.h
//  WatchList
//
//  Created by Dmitry Mazuro on 05/06/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmazonFetcher : NSObject
+ (NSDictionary *)searchDVDsByTitle:(NSString *)title;
+ (NSImage *)coverForDVDWithID:(NSUInteger *)ID;
@end

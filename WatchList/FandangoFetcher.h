//
//  FandangoFetcher.h
//  WatchList
//
//  Created by Dmitry Mazuro on 05/06/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FandangoFetcher : NSObject
+ (NSDictionary *)showtimesForZipCode:(NSUInteger *)zipCode;
+ (NSDictionary *)showtimesForTheatreID:(NSUInteger *)ID;
+ (NSDictionary *)scheduleForTheatreID:(NSUInteger *)ID;

@end

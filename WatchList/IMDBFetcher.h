//
//  IMDBFetcher.h
//  MetaDataFetchers
//
//  Created by Dmitry Mazuro on 21/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMDBFetcher : NSObject
+ (NSArray *)searchMoviesByTitle:(NSString *)title;
+ (NSDictionary *)searchMoiveByID:(NSString *)ID;
@end

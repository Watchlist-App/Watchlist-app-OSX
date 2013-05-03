//
//  IMDBFetcher.m
//  MetaDataFetchers
//
//  Created by Dmitry Mazuro on 21/04/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "IMDBFetcher.h"

@implementation IMDBFetcher

+ (NSArray *)executeIMDBFetch:(NSString *)query{
    query = [NSString stringWithFormat:@"http://imdbapi.org/?%@&type=json&plot=simple&episode=0&limit=10&yg=0&mt=none&lang=en-US&offset=&aka=simple&release=simple&business=0&tech=0",query];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:query]];
    if (!jsonData) {
        return [NSArray arrayWithObject:[NSNull null]];
    }
    NSError *error = nil;
    NSArray *results = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    if (error) {
         NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
        return [NSArray arrayWithObject:[NSNull null]];

    }
    if ([results isKindOfClass:[NSDictionary class]]) {
        if ([[results valueForKey:@"code"] isEqualTo:@"404"]) {
            results = [NSArray arrayWithObject:[NSNull null]];
        } else
            results = [NSArray arrayWithObject:results];
    }
    return results;
}

+ (NSArray *)searchMoviesByTitle:(NSString *)title{
    NSString *request = [NSString stringWithFormat:@"title=%@",title];
    return [self executeIMDBFetch:request];
}

+ (NSDictionary *)searchMoiveByID:(NSString *)ID{
    NSString *request = [NSString stringWithFormat:@"id=%@", ID];
    return [[self executeIMDBFetch:request] objectAtIndex:0];
}

@end

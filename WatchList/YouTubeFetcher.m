//
//  YouTubeFetcher.m
//  YuotubeTrailers
//
//  Created by Dmitry Mazuro on 05/05/2013.
//  Copyright (c) 2013 dmitry.mazuro. All rights reserved.
//

#import "YouTubeFetcher.h"

@interface YouTubeFetcher ()
+ (NSArray *)executeYoutubeFetch:(NSString *)query;
@end

@implementation YouTubeFetcher


+ (NSArray *)executeYoutubeFetch:(NSString *)query{
    query = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=snippet&%@&key=AIzaSyBmsQv4OMZq0uULlfPH1hbCEEj3v71i7-s&type=movie",query];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:query]];
    if (!jsonData) {
        return [NSArray arrayWithObject:[NSNull null]];
    }
    NSError *error = nil;
    NSArray *results = [[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error] valueForKey:@"items"];
    if (error) {
        NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
        return [NSArray arrayWithObject:[NSNull null]];
        
    }
    if ([results isKindOfClass:[NSDictionary class]]) {
        NSLog(@"LEL");
        if ([[results valueForKey:@"code"] isEqualTo:@"404"]) {
            results = [NSArray arrayWithObject:[NSNull null]];
        } else
            results = [NSArray arrayWithObject:results];
    }
    return results;

}

+ (NSString *)videoIDForTitle:(NSString *)title{
    NSString *request = [NSString stringWithFormat:@"q=%@",title];
    NSArray *results = [self executeYoutubeFetch:request];
    NSString *videoID = [results[0] valueForKeyPath:@"id.videoId"];
    return videoID;
}

+ (NSString *)videoURLForTitle:(NSString *)title{
    NSString *videoID = [self videoIDForTitle:title];
    NSString *youTubeURL = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", videoID];
    return youTubeURL;
}

+ (NSString *)youtubeIframeForTitle:(NSString *)title{
    NSString *videoID = [self videoIDForTitle:title];
    NSString *iframe = [NSString stringWithFormat:@"<iframe class=\"youtube-player\" type=\"text/html\" width=\"640\" height=\"385\" src=\"http://www.youtube.com/embed/%@\" frameborder=\"0\"></iframe>",videoID];
    return iframe;
}

+ (NSString *)youtubeHTMLForTitle:(NSString *)title{
    NSString *videoID = [self videoIDForTitle:title];
    NSString *iframe = [NSString stringWithFormat:@" <object width=\"640\" height=\"390\"><param name=\"movie\"value=\"https://www.youtube.com/v/M7lc1UVf-VE?version=3&autoplay=1\"></param><param name=\"allowScriptAccess\" value=\"always\"></param><embed src=\"https://www.youtube.com/v/%@?version=3&autoplay=1\"type=\"application/x-shockwave-flash\"allowscriptaccess=\"always\"width=\"640\" height=\"390\"></embed></object>",videoID];
    return iframe;
}

+ (NSString *)youtubeHTMLForID:(NSString *)ID{
    NSString *iframe = [NSString stringWithFormat:@" <object width=\"640\" height=\"390\"><param name=\"movie\"value=\"https://www.youtube.com/v/M7lc1UVf-VE?version=3&autoplay=1\"></param><param name=\"allowScriptAccess\" value=\"always\"></param><embed src=\"https://www.youtube.com/v/%@?version=3&autoplay=1\"type=\"application/x-shockwave-flash\"allowscriptaccess=\"always\"width=\"640\" height=\"390\"></embed></object>",ID];
    return iframe;
}

+ (NSString *)youtubeIframeForID:(NSString *)ID{
    NSString *iframe = [NSString stringWithFormat:@"<iframe class=\"youtube-player\" type=\"text/html\" width=\"640\" height=\"385\" src=\"http://www.youtube.com/embed/%@\" frameborder=\"0\"></iframe>",ID];
    return iframe;
}

@end

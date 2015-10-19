//
//  Functions.m
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 16/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import "Functions.h"


@implementation Functions

+(AdVideoFileType)getMediaFileResolutionFromMediaFileURL:(NSString *)mediaFileURL {

    mediaFileURL = [[mediaFileURL lastPathComponent] stringByDeletingPathExtension];
    
    if ([mediaFileURL isEqualToString:@"lo"]) {
        return AdVideoFileLo;
    }
    if ([mediaFileURL isEqualToString:@"me"]) {
        return AdVideoFileMe;
    }
    if ([mediaFileURL isEqualToString:@"hi"]) {
        return AdVideoFileHi;
    }
    
    return AdVideoFileUnknown;
}

+(AdTrackingEvents)getAdEventTypeFromEvent:(NSString *)event {
    
    if ([event isEqualToString:@"firstQuartile"]) {
        return AdEventFirstQuartile;
    }
    if ([event isEqualToString:@"midpoint"]) {
        return AdEventMidpoint;
    }
    if ([event isEqualToString:@"thirdQuartile"]) {
        return AdEventThirdQuartile;
    }
    if ([event isEqualToString:@"complete"]) {
        return AdEventComplete;
    }
    if ([event isEqualToString:@"mute"]) {
        return AdEventMute;
    }
    if ([event isEqualToString:@"unmute"]) {
        return AdEventUnmute;
    }
    if ([event isEqualToString:@"pause"]) {
        return AdEventPause;
    }
    if ([event isEqualToString:@"fullscreen"]) {
        return AdEventFullscreen;
    }
    if ([event isEqualToString:@"close"]) {
        return AdEventClose;
    }
    if ([event isEqualToString:@"acceptInvitation"]) {
        return AdEventAcceptInvitation;
    }
    
    return AdEventUnknown;
}

+(int)getIndexOfObjectInArray:(id)array
            objectToSearchFor:(id)object
                  searchAtKey:(NSString *)key
{
    int index = 0;
    
    for (int i = 0; i < [array count]; i++) {
        
        if ([[NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:key]] isEqualToString:object]) {
            
            index = i;
            break;
        }
    }
    
    return index;
}

+ (int)adDurationInSeconds:(NSString *)durationString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSDate *timeDate = [formatter dateFromString:durationString];
    
    formatter.dateFormat = @"HH";
    int hours = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat = @"mm";
    int minutes = [[formatter stringFromDate:timeDate] intValue];
    formatter.dateFormat = @"ss";
    int seconds = [[formatter stringFromDate:timeDate] intValue];
    

    int timeInSeconds = seconds + ( minutes * 60 ) + (hours * 3600);
    
    return timeInSeconds;
}

+ (void)sendHttpRequestToUrl:(NSString *)url {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
}


@end

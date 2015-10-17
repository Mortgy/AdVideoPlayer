//
//  Functions.h
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 16/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAsset.h>

//MediaFiles Resolutions
typedef NS_ENUM(NSInteger, AdVideoFileType)
{
    AdVideoFileUnknown = 0,
    AdVideoFileLo, //default
    AdVideoFileMe,
    AdVideoFileHi
};

//TrackingEvents Enum
typedef NS_ENUM(NSInteger, AdTrackingEvents)
{
    AdEventUnknown = 0,
    AdEventFirstQuartile, //default
    AdEventMidpoint,
    AdEventThirdQuartile,
    AdEventComplete,
    AdEventMute,
    AdEventUnmute,
    AdEventPause,
    AdEventResume,
    AdEventFullscreen,
    AdEventClose,
    AdEventAcceptInvitation
};

@interface Functions : NSObject

//Filter Media object
+(AdVideoFileType)getMediaFileResolutionFromMediaFileURL:(NSString *)mediaFileURL;

//Filter Events Types
+(AdTrackingEvents)getAdEventTypeFromEvent:(NSString *)event;

//Search for Objects in Dictionary
+(int)getIndexOfObjectInArray:(id)array
            objectToSearchFor:(id)object
                  searchAtKey:(NSString *)key;

//Convert duration string to seconds
+ (int)adDurationInSeconds:(NSString *)durationString;

//Send HTTP Request to update events / impressions
//If API is more complicated would use AFNetworking, but this could do it.
+ (void)sendHttpRequestToUrl:(NSString *)url;

@end

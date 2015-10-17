//
//  AdModal.h
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 16/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Functions.h"

@class typeURL, eventURL, mediaFile;

@interface AdModal : NSObject

@property (nonatomic, strong) NSString *adTitle, *error_Url, *adDuration,*adClickedUrl;
@property (nonatomic, strong) typeURL * Impression;

@property (nonatomic, strong) eventURL *EventFirstQuartile;
@property (nonatomic, strong) eventURL *EventMidpoint;
@property (nonatomic, strong) eventURL *EventComplete;
@property (nonatomic, strong) eventURL *EventThirdQuartile;
@property (nonatomic, strong) eventURL *EventMute;
@property (nonatomic, strong) eventURL *EventUnmute;
@property (nonatomic, strong) eventURL *EventPause;
@property (nonatomic, strong) eventURL *EventResume;
@property (nonatomic, strong) eventURL *EventFullscreen;
@property (nonatomic, strong) eventURL *EventClose;
@property (nonatomic, strong) eventURL *EventAcceptInvitation;

@property (nonatomic, strong) mediaFile *mediaFileLowResolution;
@property (nonatomic, strong) mediaFile *mediaFileMediumResolution;
@property (nonatomic, strong) mediaFile *mediaFileHighResolution;

-(id)initWithAdDictionary:(NSDictionary *)vest;

@end

@interface typeURL : NSObject

@property (nonatomic, strong) NSString * type, *url;

-(id)initWithObject:(NSDictionary *)Object;

@end

@interface eventURL : NSObject

@property (nonatomic, strong) NSString * event, *url;

-(id)initWithObject:(NSDictionary *)Object;

@end

@interface mediaFile : NSObject

@property (nonatomic, strong) NSString * type, *height, *width, *adUrl, *bitrate, *delivery;

-(id)initWithObject:(NSDictionary *)Object;

@end
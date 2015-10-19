//
//  AdModal.m
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 16/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import "AdModal.h"

@implementation AdModal

-(id)initWithAdDictionary:(NSDictionary *)vast {
    self = [super init];
    if (self) {
        
        vast = [[vast objectForKey:@"Ad"] objectForKey:@"InLine"];
        
        self.adTitle = [vast valueForKey:@"AdTitle"];
        self.error_Url = [vast valueForKey:@"Error"];
        self.adClickedUrl = [[[[vast objectForKey:@"Creatives"] objectForKey:@"Creative"] objectForKey:@"Linear"] objectForKey:@"VideoClicks"];
        self.adDuration = [[[[vast objectForKey:@"Creatives"] objectForKey:@"Creative"] objectForKey:@"Linear"] objectForKey:@"Duration"];

        
        self.Impression = [[typeURL alloc] initWithObject:[[vast valueForKey:@"Impression"] objectAtIndex:[Functions getIndexOfObjectInArray:[vast valueForKey:@"Impression"] objectToSearchFor:@"LR" searchAtKey:@"_id"]]];
        
        NSArray *trackingAttributes = [[[[[vast objectForKey:@"Creatives"] objectForKey:@"Creative"] objectForKey:@"Linear"] objectForKey:@"TrackingEvents"] objectForKey:@"Tracking"];
        
        for (int x = 0; x < [trackingAttributes count]; x++) {
            
            switch ([Functions getAdEventTypeFromEvent:[[trackingAttributes objectAtIndex:x] valueForKey:@"_event"]]) {
                case AdEventFirstQuartile:
                    self.EventFirstQuartile = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventMidpoint:
                    self.EventMidpoint = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventThirdQuartile:
                    self.EventThirdQuartile = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventComplete:
                    self.EventComplete = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventMute:
                    self.EventMute = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventUnmute:
                    self.EventUnmute = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventPause:
                    self.EventPause = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventResume:
                    self.EventResume = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventFullscreen:
                    self.EventFullscreen = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventClose:
                    self.EventClose = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventAcceptInvitation:
                    self.EventAcceptInvitation = [[eventURL alloc] initWithObject:[trackingAttributes objectAtIndex:x]];
                    break;
                case AdEventUnknown:
                    
                    break;
                    
                default:
                    break;
            }
        }
        
        NSArray *mediaFiles = [[[[[vast objectForKey:@"Creatives"] objectForKey:@"Creative"] objectForKey:@"Linear"] objectForKey:@"MediaFiles"] objectForKey:@"MediaFile"];

        for (int z = 0; z < [mediaFiles count]; z++) {
        
            switch ([Functions getMediaFileResolutionFromMediaFileURL:[[mediaFiles objectAtIndex:z] valueForKey:@"__text"]]) {
                case AdVideoFileLo:
                    
                    self.mediaFileLowResolution = [[mediaFile alloc] initWithObject:[mediaFiles objectAtIndex:z]];

                    break;
                case AdVideoFileMe:
                    
                    self.mediaFileMediumResolution = [[mediaFile alloc] initWithObject:[mediaFiles objectAtIndex:z]];

                    break;
                case AdVideoFileHi:
                    
                    self.mediaFileHighResolution = [[mediaFile alloc] initWithObject:[mediaFiles objectAtIndex:z]];

                    break;
                case AdVideoFileUnknown:
                    
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}

@end



@implementation typeURL

-(id)initWithObject:(NSDictionary *)Object {
    self = [super init];
    if (self) {
        self.type = [Object objectForKey:@"_id"];
        self.url = [Object objectForKey:@"__text"];
    }
    return self;
}

@end

@implementation eventURL

-(id)initWithObject:(NSDictionary *)Object {
    self = [super init];
    if (self) {
        
        self.event = [Object objectForKey:@"_event"];
        self.url = [Object objectForKey:@"__text"];
        
    }
    return self;
}

@end

@implementation mediaFile

-(id)initWithObject:(NSDictionary *)Object {
    self = [super init];
    if (self) {
        
        self.type = [Object objectForKey:@"_type"];
        self.height = [Object objectForKey:@"_height"];
        self.width = [Object objectForKey:@"_width"];
        self.adUrl = [Object objectForKey:@"__text"];
        self.bitrate = [Object objectForKey:@"_bitrate"];
        self.delivery = [Object objectForKey:@"_delivery"];
    }
    return self;
}

@end
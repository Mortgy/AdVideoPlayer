//
//  VideoPlayer.h
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 17/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPlayer : NSObject

+ (void)playMediaWithURL:(NSString *)contentVideoUrl andVastTagURL:(NSString *)vastTagUrl andShowUpSecondForMidrollAd:(int)seconds;

@end

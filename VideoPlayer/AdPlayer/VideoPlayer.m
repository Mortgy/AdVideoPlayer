//
//  VideoPlayer.m
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 17/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import "VideoPlayer.h"
#import <XMLDictionary.h>
#import "AdModal.h"
#import "AdViewController.h"
#import "AppDelegate.h"

@implementation VideoPlayer

+ (void)playMediaWithURL:(NSString *)contentVideoUrl andVastTagURL:(NSString *)vastTagUrl andShowUpSecondForMidrollAd:(int)seconds{
    
    NSData * vastXMLData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:vastTagUrl]];
    NSDictionary * vast = [NSDictionary dictionaryWithXMLData:vastXMLData];
    
    AdModal *modal = [[AdModal alloc] initWithAdDictionary:vast];
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    AdViewController *adViewController = [[AdViewController alloc] initWithNibName:@"AdVideoPlayer" bundle:[NSBundle mainBundle]];
    
    adViewController.contentVideoUrl = contentVideoUrl;
    adViewController.adObject = modal;
    adViewController.ShowUpSecondForMidrollAd = [NSNumber numberWithInt:seconds];

    [rootViewController presentViewController:adViewController animated:YES completion:^(void){

    }];
}

@end

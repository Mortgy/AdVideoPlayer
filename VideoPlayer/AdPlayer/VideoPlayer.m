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
    
    //Parse XML data into NSDictionary
    NSData * vastXMLData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:vastTagUrl]];
    NSDictionary * vast = [NSDictionary dictionaryWithXMLData:vastXMLData];
    
    //Create model of VastTag data
    AdModal *modal = [[AdModal alloc] initWithAdDictionary:vast];
    
    //Get app root  view controller to present video player from anywhere in app
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    AdViewController *adViewController = [[AdViewController alloc] initWithNibName:@"AdVideoPlayer" bundle:[NSBundle mainBundle]];
    
    //Move the required objects to video view Controller
    adViewController.contentVideoUrl = contentVideoUrl;
    adViewController.adObject = modal;
    adViewController.ShowUpSecondForMidrollAd = [NSNumber numberWithInt:seconds];

    [rootViewController presentViewController:adViewController animated:YES completion:^(void){

    }];
}

@end

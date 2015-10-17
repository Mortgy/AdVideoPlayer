//
//  ViewController.m
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 16/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import "ViewController.h"
#import "VideoPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)playVideo:(id)sender {
    
    [VideoPlayer playMediaWithURL:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" andVastTagURL:@"http://ad4.liverail.com/?LR_PUBLISHER_ID=131899&LR_SCHEMA=vast3" andShowUpSecondForMidrollAd:5];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

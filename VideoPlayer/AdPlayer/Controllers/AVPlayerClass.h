//
//  AVPlayerClass.h
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 17/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class AVPlayer;

@interface AVPlayerClass : UIView

@property (nonatomic) AVPlayer* player;

- (void)setMovieToPlayer:(AVPlayer*)player;

@end

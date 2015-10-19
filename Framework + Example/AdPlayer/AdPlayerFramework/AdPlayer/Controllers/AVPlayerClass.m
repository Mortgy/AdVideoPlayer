//
//  AVPlayerClass.m
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 17/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import "AVPlayerClass.h"

@implementation AVPlayerClass

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer*)player {
    return [(AVPlayerLayer*) [self layer] player];
}

- (void)setMovieToPlayer:(AVPlayer *)player {
    [(AVPlayerLayer*)[self layer] setPlayer:player];
}

@end

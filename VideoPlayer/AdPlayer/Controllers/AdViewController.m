//
//  AdViewController.m
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 17/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import "AdViewController.h"
#import "AVPlayerClass.h"

@class AVPlayer;
@class AVPlayerClass;

@interface AdViewController ()

//Better to use Properties instead of ivars for a better performance

//Video Player
@property (strong, nonatomic) IBOutlet UILabel *duration_lbl;
@property (strong, nonatomic) IBOutlet UIButton *playPause_btn;
@property (strong, nonatomic) NSTimer *vidPlayerStatusTimer;
@property (strong, nonatomic) AVPlayer *vidPlayer;
@property (strong, nonatomic) IBOutlet AVPlayerClass *vidPlayerView;

//Ad Video Player
@property (strong, nonatomic) AVPlayer *adPlayer;
@property (strong, nonatomic) IBOutlet AVPlayerClass *AdPlayerView;
@property (strong, nonatomic) NSTimer *adPlayerStatusTimer;
@property (strong, nonatomic) IBOutlet UIButton *adClose_btn;
@property (nonatomic) int adDuration;
@property (nonatomic) int adPlayed;

@end

@implementation AdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //initialize Video Player
    [self setupVideo];
    
    //Initialize Ad Video Player now to avoid delays when ad starts
    [self setupAdVideo];
}

//Video Player first initialization
- (void) setupVideo {
    
    //Generate AVAssets
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:self.contentVideoUrl]];
    AVPlayerItem *vidPlayerItem = [[AVPlayerItem alloc]initWithAsset:asset];

    self.vidPlayer = [AVPlayer playerWithPlayerItem:vidPlayerItem];
    [self.vidPlayerView setMovieToPlayer:self.vidPlayer];
    
    [self initializeTimerAndStartVideoPlaying];
    
    // Get notified when when Video Player ends
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vidDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:vidPlayerItem];
    

}

//Dismiss video player when video is finished
- (void) vidDidFinishPlaying:(NSNotification *) notification {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Initialize Ad Video
- (void) setupAdVideo {
    
    //Choose MediaFile Resolution URL
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:self.adObject.mediaFileMediumResolution.adUrl]];
    AVPlayerItem *adPlayerItem = [[AVPlayerItem alloc]initWithAsset:asset];
    
    self.adPlayer = [AVPlayer playerWithPlayerItem:adPlayerItem];
    [self.AdPlayerView setMovieToPlayer:self.adPlayer];
    
    self.adDuration = [Functions adDurationInSeconds:self.adObject.adDuration];
    
    // Subscribe to the AVPlayerItem's DidPlayToEndTime notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:adPlayerItem];


}

- (void)startPlayingAdVideoPlayer {
    
    self.AdPlayerView.hidden = NO;
    self.adPlayed = YES;
    
    //Create timer to update Events / Duration Label
    self.adPlayerStatusTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                                target:self
                                                              selector:@selector(updateAdEvents)
                                                              userInfo:nil
                                                               repeats:YES];
    //Create Close button timer
    [NSTimer scheduledTimerWithTimeInterval:10
                                     target:self
                                   selector:@selector(showCloseButton)
                                   userInfo:nil
                                    repeats:NO];
    
    }

- (void)initializeTimerAndStartVideoPlaying {
    //start Timer label update
    self.vidPlayerStatusTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                                 target:self
                                                               selector:@selector(updateDurationLabel)
                                                               userInfo:nil
                                                                repeats:YES];
    
    // Start Video instantly
    [self.vidPlayer play];
    [self.playPause_btn setTitle:@"Pause" forState:UIControlStateNormal];

}

//Show close button after 10 seconds reguardless if video is playing or not
//in case if video file had buffering issues, we shouldn't bother user and bug his app
- (void)showCloseButton {
    
    [self.adClose_btn setHidden:NO];
}

//Update Ad Events
- (void)updateAdEvents {
    
    //Update Ad Duration Label
    self.duration_lbl.text = [NSString stringWithFormat:@"%@ - %@",[self stringFromSeconds:[self getCurrentTimeForPlayer:self.adPlayer]], [self stringFromSeconds:CMTimeGetSeconds(self.adPlayer.currentItem.duration)]];

    
    int adDurationQuarter = self.adDuration / 4;
    
    //Update Tracking 25% of Ad watched
    if ((int)[self getCurrentTimeForPlayer:self.adPlayer] == adDurationQuarter) {
        [Functions sendHttpRequestToUrl:self.adObject.EventFirstQuartile.url];
    }
    
    //Update Tracking 55% of Ad watched
    if ((int)[self getCurrentTimeForPlayer:self.adPlayer] == (adDurationQuarter * 2)) {
        [Functions sendHttpRequestToUrl:self.adObject.EventMidpoint.url];
    }
    
    //Update Tracking 75% of Ad watched
    if ((int)[self getCurrentTimeForPlayer:self.adPlayer] == (adDurationQuarter * 3)) {
        [Functions sendHttpRequestToUrl:self.adObject.EventThirdQuartile.url];
    }
    
    //Update Tracking 100% of Ad watched
    if ((int)[self getCurrentTimeForPlayer:self.adPlayer] == (adDurationQuarter * 4)) {
        [Functions sendHttpRequestToUrl:self.adObject.EventComplete.url];
    }
}

//AdVideo did finish
- (void) adDidFinishPlaying:(NSNotification *) notification {
    [self closeAdProcess];
}

//Close Ad
- (IBAction)closeAd:(id)sender {
    
    //Notify Tracker Ad got closed.
    [Functions sendHttpRequestToUrl:self.adObject.EventClose.url];
    
    //Invalidate Ad Video
    [self.adPlayer pause];
    [self closeAdProcess];
}

-(void) closeAdProcess {
    [self.AdPlayerView setHidden:YES];  //Hide Ad View
    [self.adClose_btn setHidden:YES];   //Hide Ad close button

    //Hide Ad View
    [self.AdPlayerView setHidden:YES];
    [self.adClose_btn setHidden:YES];

    [self.adPlayerStatusTimer invalidate];
    
    //Resume Video Playing
    [self initializeTimerAndStartVideoPlaying];
}

// Play / Pause Video
- (IBAction)playPause:(id)sender {
    
    if (self.vidPlayer.rate == 0) {
        [self.vidPlayer play];
        [self.playPause_btn setTitle:@"Pause" forState:UIControlStateNormal];
        self.vidPlayerStatusTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                                target:self
                                                              selector:@selector(updateDurationLabel)
                                                              userInfo:nil
                                                               repeats:YES];
    }else {
        [self.vidPlayer pause];
        [self.playPause_btn setTitle:@"Play" forState:UIControlStateNormal];
        [self.vidPlayerStatusTimer invalidate];

    }
}

//Close video Player
- (IBAction)closeVideo:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Update Video Player Label
- (void)updateDurationLabel
{
    //Check if video reached the ShowUpSeconds for Ad
    if (!self.vidPlayer.rate == 0 && !self.adPlayed) {
        if ((int)[self getCurrentTimeForPlayer:self.vidPlayer] == [self.ShowUpSecondForMidrollAd intValue]) {
            [self playPause:nil];
            [self startPlayingAdVideoPlayer];
            [self.adPlayer play];
            
            //Report impression
            [Functions sendHttpRequestToUrl:self.adObject.Impression.url];
        }
    }
    
    //Update Label
    self.duration_lbl.text = [NSString stringWithFormat:@"%@ - %@",[self stringFromSeconds:[self getCurrentTimeForPlayer:self.vidPlayer]], [self stringFromSeconds:CMTimeGetSeconds(self.vidPlayer.currentItem.duration)]];
}

//get current time for player
- (double) getCurrentTimeForPlayer:(AVPlayer*)player
{
    AVPlayerItem * currentItem = player.currentItem;
    double startTime = 0;
    
    if(currentItem)
    {
        startTime = CMTimeGetSeconds(player.currentTime);
    }
    
    return startTime;
}

//get string value of seconds ( time format )
- (NSString *) stringFromSeconds:(double) value
{
    NSTimeInterval interval = value;
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.vidPlayer pause];
    [self.adPlayer pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Override Device Orientation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return (int)UIInterfaceOrientationMaskLandscape;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

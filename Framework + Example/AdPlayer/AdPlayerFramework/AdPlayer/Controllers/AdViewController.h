//
//  AdViewController.h
//  VideoPlayer
//
//  Created by Muhammed Mortgy on 17/10/15.
//  Copyright © 2015 Muhammed Mortgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AdModal.h"

@interface AdViewController : UIViewController

@property (strong, nonatomic) NSString * contentVideoUrl;
@property (strong, nonatomic) AdModal * adObject;
@property (strong, nonatomic) NSNumber * ShowUpSecondForMidrollAd;

@end

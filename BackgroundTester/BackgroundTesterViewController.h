//
//  BackgroundTesterViewController.h
//  BackgroundTester
//
//  Created by Dave Stevenson on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>

@interface BackgroundTesterViewController : UIViewController <CLLocationManagerDelegate, AVAudioPlayerDelegate> {
    
    CLLocationManager *locationManager;
    AVAudioPlayer *player;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) AVAudioPlayer *player;

- (IBAction)scheduleLocalNotification:(id)sender;
- (IBAction)startSignificantChangeTracking:(id)sender;
- (IBAction)startAllChangeTracking:(id)sender;
- (IBAction)startPlayingAudio:(id)sender;
- (IBAction)stopPlayingAudio:(id)sender;

@end

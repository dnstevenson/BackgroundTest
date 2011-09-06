//
//  BackgroundTesterViewController.m
//  BackgroundTester
//
//  Created by Dave Stevenson on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BackgroundTesterViewController.h"

@implementation BackgroundTesterViewController

@synthesize locationManager;
@synthesize player;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)scheduleLocalNotification:(id)sender {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    
    NSUInteger unitFlags = NSMinuteCalendarUnit| NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit |
    NSYearCalendarUnit;
    
    NSDate *now = [NSDate date];
    dateComps = [calendar components:unitFlags fromDate:now];
    
    [dateComps setMinute:[dateComps minute]+1];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    //[dateComps release];   
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@.", nil), @"Test Alarm"];
    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
    
    //localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"Test Event" forKey:@"key"];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [localNotif release];
}

- (IBAction)startSignificantChangeTracking:(id)sender {
    NSLog(@"startSignificantChangeTracking");
    
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    [locationManager startMonitoringSignificantLocationChanges];
}

- (IBAction)startAllChangeTracking:(id)sender {
    NSLog(@"startAllChangeTracking");
    // server did not accept client registration 68
    
    if (nil == locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 0.1;
    
    [locationManager startUpdatingLocation];
}

- (IBAction)startPlayingAudio:(id)sender {
    NSLog(@"startPlayingAudio");

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"audio" ofType:@"m4a"]];
    if (player == nil) {
        NSLog(@"player was nil");
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];	
    }
    [self.player play];
}

- (IBAction)stopPlayingAudio:(id)sender {
    [self.player stop];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"didUpdateToLocation");
    
    CLLocationDistance distanceMoved = [newLocation distanceFromLocation:oldLocation];
    NSLog(@"you've moved %fm", distanceMoved);
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}

- (void)stopUpdatingLocation:(NSString *)state {
    NSLog(@"stopUpdatingLocation");
}

@end

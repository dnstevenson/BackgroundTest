//
//  BackgroundTesterAppDelegate.h
//  BackgroundTester
//
//  Created by Dave Stevenson on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BackgroundTesterViewController;

@interface BackgroundTesterAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet BackgroundTesterViewController *viewController;

@end

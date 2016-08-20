//
//  AppDelegate.h
//  SpotMe
//
//  Created by AliNaveed on 6/18/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WebServices.h"
@class SplashScreen;
@class WebServices;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    UINavigationController *navController;
    WebServices *webSer;
    CLLocationManager *locMgr;

}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SplashScreen *viewController;
@property(nonatomic,retain) NSString *access_token ;

@property(nonatomic,retain)    WebServices *webSer;
@end

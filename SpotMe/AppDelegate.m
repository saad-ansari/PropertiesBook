//
//  AppDelegate.m
//  SpotMe
//
//  Created by AliNaveed on 6/18/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "AppDelegate.h"
#import "WebServices.h"
#import "LogInViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SplashScreen.h"
@implementation AppDelegate
@synthesize access_token ,viewController;
@synthesize webSer;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    webSer = [[WebServices alloc] init];
    
    
    webSer.access_token = self.access_token ;
    
    locMgr=[[CLLocationManager alloc ]init];
    
    locMgr.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //locMgr.distanceFilter = 300;
    locMgr.delegate = self;
    [locMgr startUpdatingLocation];
    [webSer getServerTime];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    } else {
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
       //self.window.rootViewController = self.viewController;
    
    self.viewController=[[SplashScreen alloc] init];
    navController=[[UINavigationController alloc] initWithRootViewController:self.viewController];

    
        UIColor *mycolor = [UIColor colorWithRed:(243.0f/255.0f) green:(167.0f/255.0f) blue:(7.0f/255.0f) alpha:1.0f];
    
    [navController.navigationBar setBarTintColor:mycolor];
    [navController.navigationBar setTranslucent:NO];

    self.window.rootViewController = navController;

    
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark-Core location delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
   // [locMgr stopUpdatingLocation];
    
    
   // NSLog(@"%f %f",newLocation.coordinate.longitude,newLocation.coordinate.latitude);
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:@"latitude"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:@"longitude"];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url];
}

@end

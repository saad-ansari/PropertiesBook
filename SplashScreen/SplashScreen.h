//
//  SplashScreen.h
//  Awkaf
//
//  Created by AliNaveed on 5/29/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//  Sample 

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebServices.h"
#import "InfiniTabBar.h"

@interface SplashScreen : UIViewController<InfiniTabBarDelegate>

{
    InfiniTabBar *tabBar;
      IBOutlet UIImageView *DefaultImage;
        IBOutlet UITabBarController *tabbar;

}
@end

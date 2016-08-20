//
//  SpotMeScreen.h
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebServices.h"
#import "InfiniTabBar.h"

@interface SpotMeScreen : UIViewController<WebServicesDelegate,InfiniTabBarDelegate>

{
    	InfiniTabBar *tabBar;
    IBOutlet UITabBarController *tabbar;
    AppDelegate *appDelegate;
    IBOutlet UIView *menuView;
    


}
@property (nonatomic, retain) InfiniTabBar *tabBar;
-(IBAction)checkin:(id)sender;
-(void)updateProfile;
- (void)TabBarValues;
@end

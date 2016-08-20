//
//  SplashScreen.m
//  Awkaf
//
//  Created by AliNaveed on 5/29/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "SplashScreen.h"
#import <BlocksKit/BlocksKit.h>
#import "LogInViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "UIAlertView+BlocksKit.h"
#import "NSTimer+BlocksKit.h"

@interface SplashScreen ()

@end

@implementation SplashScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        [self setTabbarInterface];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self setImageForiPhone];
    
    [NSTimer bk_scheduledTimerWithTimeInterval:2.0 block:^(NSTimer *timer) {
         [self setImageForiPhone2];
    } repeats:NO];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setImageForiPhone2
{
    
    if ([UIScreen instancesRespondToSelector:@selector(scale)])
    {
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        if (scale > 1.0)
        {
            if([[ UIScreen mainScreen ] bounds ].size.height == 568)
                //iphone 5
                [DefaultImage setImage: [UIImage imageNamed:@"Cumlogo-568h@2x.png"]];
            else
                [DefaultImage setImage: [UIImage imageNamed:@"Cumlogo@2x.png"]];
            //iphone retina screen
        }
        else
            [DefaultImage setImage: [UIImage imageNamed:@"Cumlogo.png"]];
        //iphone screen
    }
    
    [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
      
        [self setTabbarInterface];
        [tabbar setSelectedIndex:3];
        
        tabbar.navigationItem.hidesBackButton = YES;

        
        [self.navigationController pushViewController:tabbar animated:YES];


    } repeats:NO];
    
    
      
}

#pragma mark-tabbar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    [tabBarController.navigationController setNavigationBarHidden:YES];
    
    
}


-(void)setTabbarInterface{
    
    
    UITabBar *tabBar = tabbar.tabBar;
    [tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarbg.png"]];
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    
    item0.title = @"Home";
    
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"m2-profile_but_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-profile_butt.png"]
     ];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    item1.title = @"My Account";
    
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"m2-add_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-add_butt.png"]];
    
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"m2-msg_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-msg_butt.png"]];
    item2.title = @"Search";
    
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    
    item3.title = @"Add Property";
    
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"m2-locate_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-locate_butt.png"]];
    
    
    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    item4.title = @"Contact Us";
    
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"m2-locate_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-locate_butt.png"]];
    
    
    
}

-(void)setImageForiPhone
{
    if ([UIScreen instancesRespondToSelector:@selector(scale)])
    {
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        if (scale > 1.0)
        {
            if([[ UIScreen mainScreen ] bounds ].size.height == 568)
                //iphone 5
                DefaultImage.image = [UIImage imageNamed:@"Default-568h@2x.png"];
            else
                DefaultImage.image = [UIImage imageNamed:@"Default@2x.png"];
            //iphone retina screen
        }
        else
            DefaultImage.image = [UIImage imageNamed:@"Default.png"];
        //iphone screen
    }
}

@end

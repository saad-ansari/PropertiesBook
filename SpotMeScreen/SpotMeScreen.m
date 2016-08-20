//
//  SpotMeScreen.m
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "SpotMeScreen.h"
#import "Diet.h"
#import "ProfileViewController.h"
#import "ComparePeopleViewController.h"
#import "LocateMeViewController.h"
#import "MessageViewController.h"
#import "WorkOutTrackerController.h"
#import "ComparePeopleViewController.h"
#import "MarqueeLabel.h"
#import "ImageProgressViewController.h"
@interface SpotMeScreen ()

@end

@implementation SpotMeScreen
@synthesize tabBar;
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
    self.title = @"Spot Me";
    
    self.navigationItem.hidesBackButton = YES;
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(!IS_IPHONE_5)
        [menuView setFrame:CGRectMake(menuView.frame.origin.x, menuView.frame.origin.y-34, menuView.frame.size.width, menuView.frame.size.height)];
    
    [appDelegate.webSer getHeadLine];
    [appDelegate.webSer setDelegate:self];

   // [self TabBarValues];
    
    [self setTabbarInterface];
    [tabbar setSelectedIndex:3];
    [self.navigationController pushViewController:tabbar animated:YES];


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-tabbar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{


    [tabBarController.navigationController setNavigationBarHidden:YES];
    

}
-(IBAction)pushToNext:(id)sender
{
    
    NSLog(@"-----%ld",(long)[sender tag]);
    
    if([sender tag]==5)
    
    {
        Diet *controller=[[Diet alloc] initWithNibName:@"Diet" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];

    
    }
    
    else if([sender tag]==4)
    {
    
        WorkOutTrackerController *controller_1=(WorkOutTrackerController*)[(UINavigationController*)[tabbar.viewControllers objectAtIndex:4] visibleViewController];
        controller_1.isRoot = YES;

        
        
        [self setTabbarInterface];
        [tabbar setSelectedIndex:4];
        [self.navigationController pushViewController:tabbar animated:YES];

        
    
    }
    else{
        ProfileViewController *controller=(ProfileViewController*)[(UINavigationController*)[tabbar.viewControllers objectAtIndex:0] visibleViewController];
      
        controller.userDict=[Singleton getUserData] ;
        controller.isRoot=YES;
           
    
   
        
        ComparePeopleViewController *controller_=(ComparePeopleViewController*)[(UINavigationController*)[tabbar.viewControllers objectAtIndex:1] visibleViewController];
 
        controller_.isRoot=YES;
        

        WorkOutTrackerController *controller_1=(WorkOutTrackerController*)[(UINavigationController*)[tabbar.viewControllers objectAtIndex:4] visibleViewController];
        controller_1.isRoot = YES;
        controller_.isRoot=YES;
        
    
    [self setTabbarInterface];
    [tabbar setSelectedIndex: [sender tag]];
    [self.navigationController pushViewController:tabbar animated:YES];
    }

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
-(IBAction)checkin:(id)sender{

    [appDelegate.webSer updateUserLocation];
    [appDelegate.webSer setDelegate:self];

}
#pragma mark -
#pragma WebservicesDelegate

-(void)webServiceRequestFinished:(NSString *)responseStr ;{

    NSLog(@"aayyyyyaa response %@",responseStr);

    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        NSLog(@"dicationary %@",[[[objectsDict valueForKey:@"Result"] objectAtIndex:0] valueForKey:@"text"]);
        
        NSString *headLineText = [[[objectsDict valueForKey:@"Result"] objectAtIndex:0] valueForKey:@"text"];
        [self HeadLines:headLineText];
    }
    
}

-(void)HeadLines:(NSString *)title
{
    float forIphone4 = 32;
    if (IS_WIDESCREEN)forIphone4 = 65;

    // Second continuous label example
    MarqueeLabel *continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(26, forIphone4,274,21) rate:100.0f andFadeLength:10.0f];

    continuousLabel2.tag = 101;
    continuousLabel2.marqueeType = MLContinuous;
    continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
    continuousLabel2.continuousMarqueeExtraBuffer = 50.0f;
    continuousLabel2.numberOfLines = 1;
    continuousLabel2.opaque = NO;
    continuousLabel2.enabled = YES;
    continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
    continuousLabel2.textAlignment = NSTextAlignmentLeft;
    continuousLabel2.textColor = [UIColor whiteColor];
    continuousLabel2.backgroundColor = [UIColor clearColor];
    continuousLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.000];
    continuousLabel2.text = title;
    
    [self.view addSubview:continuousLabel2];
}
//http://www.spotme.biz/webservices/public/index.php?controller=web&action=GetWorkoutByDate&userid=1&sessionid=7fbe90c16b7cf05217a539971a16e9c3&targetid=1&date=2013-08-24


//----
- (void)TabBarValues {
    
	// Items
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
    [favorites setFinishedSelectedImage:[UIImage imageNamed:@"m2-add_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-add_butt.png"]];
	UITabBarItem *topRated = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    
    [topRated setFinishedSelectedImage:[UIImage imageNamed:@"m2-add_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-add_butt.png"]];
    
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTitle:@"Message" image:[UIImage imageNamed:@"m2-msg_butt_press.png"] tag:2];
    //    [featured  setFinishedSelectedImage:[UIImage imageNamed:@"m2-msg_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-msg_butt.png"]];
    
	UITabBarItem *recents = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:3];
    [recents setFinishedSelectedImage:[UIImage imageNamed:@"m2-locate_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-locate_butt.png"]];
    
	UITabBarItem *contacts = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
    [contacts setFinishedSelectedImage:[UIImage imageNamed:@"m2-locate_butt_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-locate_butt.png"]];
	UITabBarItem *history = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
    [history setFinishedSelectedImage:[UIImage imageNamed:@"m2-profile_but_press.png"] withFinishedUnselectedImage: [UIImage imageNamed:@"m2-profile_butt.png"]
     ];
    
	UITabBarItem *bookmarks = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:6];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:7];
	
	
	// Tab bar
	self.tabBar = [[InfiniTabBar alloc] initWithItems:[NSArray arrayWithObjects:favorites,
													   topRated,
													   featured,
													   recents,
													   contacts,
													   history,
													   bookmarks,
													   search,
													   
                                                       nil]];
	
	// Don't show scroll indicator
	self.tabBar.showsHorizontalScrollIndicator = NO;
	self.tabBar.infiniTabBarDelegate = self;
	self.tabBar.bounces = NO;
	
	[self.view addSubview:self.tabBar];
}

- (void)scrollToTabBar3 {
	[self.tabBar scrollToTabBarWithTag:2 animated:NO];
}

- (void)scrollAnimatedToTabBar1 {
	[self.tabBar scrollToTabBarWithTag:0 animated:YES];
}

- (void)selectItem8 {
	[self.tabBar selectItemWithTag:7];
}

- (void)scrollToPreviousTabBar {
	[self.tabBar scrollToTabBarWithTag:self.tabBar.currentTabBarTag - 1 animated:YES];
}

- (void)scrollToNextTabBar {
	[self.tabBar scrollToTabBarWithTag:self.tabBar.currentTabBarTag + 1 animated:YES];
}

- (void)infiniTabBar:(InfiniTabBar *)tabBar didScrollToTabBarWithTag:(int)tag {

}

- (void)infiniTabBar:(InfiniTabBar *)tabBar didSelectItemWithTag:(int)tag {
//	self.fLabel.text = [NSString stringWithFormat:@"%d", tag + 1];
}


- (void)setNewItems {
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0]; featured.badgeValue = @"1";
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:1];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
	UITabBarItem *more = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
	
	[self.tabBar setItems:[NSArray arrayWithObjects:featured,
						   mostViewed,
						   search,
						   favorites,
						   more, nil] animated:NO];
	
}

- (void)setOldItemsAnimated {
	UITabBarItem *favorites = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
	UITabBarItem *topRated = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
	UITabBarItem *featured = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
	UITabBarItem *recents = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:3];
	UITabBarItem *contacts = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
	UITabBarItem *history = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:5];
	UITabBarItem *bookmarks = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:6];
	UITabBarItem *search = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:7];
	UITabBarItem *downloads = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:8]; downloads.badgeValue = @"2";
	UITabBarItem *mostRecent = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:9];
	UITabBarItem *mostViewed = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:10];
	
	[self.tabBar setItems:[NSArray arrayWithObjects:favorites,
						   topRated,
						   featured,
						   recents,
						   contacts,
						   history,
						   bookmarks,
						   search,
						   downloads,
						   mostRecent,
						   mostViewed, nil] animated:YES];
	
}

@end

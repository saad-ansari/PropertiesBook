//
//  Diet.m
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "Diet.h"
#import "DetailViewController.h"
#import "WorkOutGuideViewController.h"
#import "SpreadWordViewController.h"
#import "CalorieCalculatorController.h"
@interface Diet ()
{

    CalorieCalculatorController *calcontroller;

}

@end

@implementation Diet

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
      //  self.title = @"Diet";
    // [self setTitle:@"MY DIET"];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{

   // [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
    //[self.navigationController setNavigationBarHidden:YES];
    


}

-(IBAction)pushToNext:(id)sender
{
    
   
    
    if ([sender tag] == 1 || [sender tag]==2) {
        
         DetailViewController *Push;
        Push = [[DetailViewController alloc]init];
        Push.valuez = [NSString stringWithFormat:@"%d",[sender tag]];
       
         [self.navigationController pushViewController:Push animated:YES];
    }
   
    else if ([sender tag]==4)
    {
    
        WorkOutGuideViewController *workoutGuide=[[WorkOutGuideViewController alloc]init];
        [self.navigationController pushViewController:workoutGuide animated:YES];
        
        
    
    }
    else if([sender tag]==5)
    {
        SpreadWordViewController *spreadWord=[[SpreadWordViewController alloc]init];
        [self.navigationController pushViewController:spreadWord animated:YES];
        spreadWord=nil;
        
    
    }
    else  {
        calcontroller = [[CalorieCalculatorController alloc]init];
     
         [self.navigationController pushViewController:calcontroller animated:YES];

        
    }
   
    
  
    
    
    
}


@end

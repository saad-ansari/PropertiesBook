//
//  CalorieCalculatorController.m
//  SpotMe
//
//  Created by Muneeba Meer on 6/27/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "CalorieCalculatorController.h"

@interface CalorieCalculatorController ()

@end

@implementation CalorieCalculatorController

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
    totalCalories=440;
    smartPicker.delegate=self;
    dbObj=[[Database alloc] init];
    [dbObj CopyDatabaseIfNeeded];
    foodItems=[dbObj getFoodsList];
    smartPicker=[[SmartUIPicker alloc] initWithItems:foodItems];
    smartPicker.delegate=self;
    [self setBtnTitles];
    
    
   
   
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    

        
        [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
        [self.navigationController setNavigationBarHidden:NO];
        
        
    
    
}
-(void)setBtnTitles{

    if(!IS_IPHONE_5)
        [  calorieView setFrame:CGRectMake(61, 290, calorieView.frame.size.width, calorieView.frame.size.height)];
    NSString *title__=[NSString stringWithFormat:@"%@ - %@",[[foodItems objectAtIndex:0] itemName],[[foodItems objectAtIndex:0] calories]];
    
    for (int i=1; i<6; i++) {
        
        UIButton *btn=(UIButton*)[self.view viewWithTag:i];
        [btn setTitle:title__ forState:UIControlStateNormal];
    }

     [lblCalories setText:[NSString stringWithFormat:@"%d",totalCalories]];

}

-(void)updateTitle:(NSString*)title_ withTag:(int)btnTag{

    
    UIButton *btn=(UIButton*)[self.view viewWithTag:btnTag];
    [btn setTitle:title_ forState:UIControlStateNormal];
}
    


#pragma mark-IBActions

-(IBAction)buttonClicked:(id)sender
{
    UIButton *btn=sender;
    selectedBtn=btn.tag;

   if(![self.view.subviews containsObject:smartPicker])
       [self.view addSubview:smartPicker];
    

}
-(void)addUpCalories:(NSString*)value {
    
    UIButton *btn=(UIButton*)[self.view viewWithTag:selectedBtn];
    NSLog(@"btn title %@",btn.titleLabel.text);
    
    if([btn.titleLabel.text length]>0)
    totalCalories=totalCalories- [[[btn.titleLabel.text componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    
    if([value length]>0)
    totalCalories=totalCalories+ [[[value componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    [lblCalories setText:[NSString stringWithFormat:@"%d",totalCalories]];
    

}
#pragma mark-SmartPicker Delegates
-(void) SmartUIPickerDone:(NSString*)value {

  
    if([value length]>0)
    {
    [self addUpCalories:value];
    [self updateTitle:value withTag:selectedBtn];
    }
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

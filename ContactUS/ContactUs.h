//
//  ViewController.h
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DemoTextField.h"

@interface ContactUs : UIViewController
{


    IBOutlet UITableView *tbleView_;
    NSMutableArray *fieldsArray;
    NSMutableDictionary *dataDictionary;
    IBOutlet UILabel *date_;
    IBOutlet UIToolbar *bar;
    IBOutlet UIDatePicker *datePicker;
    
    AppDelegate *appDelegate;
    NSArray *sortedKeys;
    NSMutableArray *updateFieldsArray;
    NSDateFormatter *dateFormat;
    
    IBOutlet UIView *mainViewForChartandImage;
   
}
@property(nonatomic,assign)BOOL isRoot;
@property(nonatomic,retain)NSDictionary *userDict;
-(IBAction)updateProfile:(id)sender;
-(IBAction)MainPush:(id)sender;

-(IBAction)forImageProgress;
-(IBAction)forImageChart;


@property (strong, nonatomic) IBOutlet DemoTextField *emailTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *phoneTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *ageTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *zipTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *shoppingFrequenceTextField;

- (IBAction)createAccount:(id)sender;

@end

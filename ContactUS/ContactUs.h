//
//  ViewController.h
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

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
@end

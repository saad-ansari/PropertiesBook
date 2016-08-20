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
#import "CustomPicker.h"
@interface ContactUs : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{


    IBOutlet UITableView *tbleView_;
    NSMutableArray *fieldsArray;
    NSMutableDictionary *dataDictionary;
    IBOutlet UILabel *date_;
    IBOutlet UIToolbar *bar;
    IBOutlet UIDatePicker *datePicker;
    
    AppDelegate *appDelegate;
    IBOutlet UIPickerView *Source;
    NSMutableArray *SourceArray ;
    CustomPicker *distancePicker;
    IBOutlet UIScrollView *contactUSScr;
}
@property(nonatomic,assign)BOOL isRoot;
@property(nonatomic,retain)NSDictionary *userDict;
-(IBAction)updateProfile:(id)sender;
-(IBAction)MainPush:(id)sender;

-(IBAction)forImageProgress;
-(IBAction)forImageChart;


@property (strong, nonatomic) IBOutlet DemoTextField *emailTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *nameTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *phoneTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *subjectTextField;
@property (strong, nonatomic) IBOutlet DemoTextField *sourceTextField;


- (IBAction)createAccount:(id)sender;

@end

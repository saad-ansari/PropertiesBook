//
//  ViewController.m
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import "ContactUs.h"
#import "HeaderView.h"
#import "ProfileCell.h"
#import "JMImageCache.h"
#import "MBProgressHUD.h"
#import "UIAlertView+BlocksKit.h"
#import <BlocksKit/BlocksKit.h>
#import "WorkViewController.h"
#import "ImageProgressViewController.h"

#import "UIActionSheet+BlocksKit.h"
#import "UIAlertView+BlocksKit.h"

@interface ContactUs ()

@end

@implementation ContactUs
@synthesize userDict,isRoot;


- (IBAction)createAccount:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Do something interesting!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    if (![self validateInputInView:self.view]){
        
        [alertView setMessage:@"Invalid information please review and try again!"];
        [alertView setTitle:@"Login Failed"];
    }
    
    [alertView show];
}


- (BOOL)validateInputInView:(UIView*)view
{
    for(UIView *subView in view.subviews){
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[DemoTextField class]]){
            if (![(MHTextField*)subView validate]){
                return NO;
            }
        }
    }
    
    return YES;
}


-(void)ShowPickerforSource
{

    UIActionSheet *testSheet = [UIActionSheet bk_actionSheetWithTitle:@"Select Gym"];
    [testSheet bk_addButtonWithTitle:@"Select" handler:^{
        
    }];
    
    [testSheet bk_setCancelButtonWithTitle:@"" handler:^{ }];
    [testSheet bk_addButtonWithTitle:@"e" handler:^{}];
    [testSheet bk_addButtonWithTitle:@"e" handler:^{}];
    [testSheet addSubview:Source];
    
    
    [testSheet showInView:self.view];
}


// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 7;
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [SourceArray objectAtIndex:row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


    _sourceTextField.text = [SourceArray objectAtIndex:row];
}



-(IBAction)selectSource
{
    
    if(distancePicker==nil)
        distancePicker=[[CustomPicker alloc] initWithItems:SourceArray];
    distancePicker.delegate=self;
    
    if(![self.view.subviews containsObject:distancePicker])
        [self.view addSubview:distancePicker];
    

}

#pragma mark -Smart Picker Delegate
-(void) SmartUIPickerDone:(NSString*)value  {
    
     _sourceTextField.text = value;
    [distancePicker removeFromSuperview];
 
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SourceArray = [[NSMutableArray alloc] init];
    //[SourceArray addObject:@"Search Engine محرك البحث"];
    
    [SourceArray addObject:@"محرك البحث"];

    [SourceArray addObject:@"Social Network"];
    [SourceArray addObject:@"Advertisement"];
    [SourceArray addObject:@"Friends"];
    [SourceArray addObject:@"Events"];
    [SourceArray addObject:@"Forum or Blog"];
    [SourceArray addObject:@"Others"];
    
    
    // iOS 7
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeTop];
    
    [_emailTextField setRequired:YES];
    [_emailTextField setEmailField:YES];
    [_nameTextField setRequired:YES];
    [_subjectTextField setRequired:YES];
    
    
    _emailTextField.backgroundColor = [UIColor lightGrayColor];
    _nameTextField.backgroundColor = [UIColor lightGrayColor];
    _phoneTextField.backgroundColor = [UIColor lightGrayColor];
    _subjectTextField.backgroundColor = [UIColor lightGrayColor];
    _sourceTextField.backgroundColor = [UIColor lightGrayColor];

    
    Source = [[UIPickerView alloc] init];
    [Source setDataSource: self];
    [Source setDelegate: self];
    Source.showsSelectionIndicator = YES;
    Source.frame = CGRectMake(0, 95, 320, 500);
    Source.tag = 2;
    
    
    [contactUSScr setContentSize:CGSizeMake(0, 1000)];
    

	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    self.navigationController.tabBarController.navigationController.visibleViewController.navigationItem.title=@"Contact Us";

    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; // this will change the back button tint
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationItem.hidesBackButton = YES;


    
    
}
-(void)viewWillDisappear:(BOOL)animated{

   
    

}
-(IBAction)changeDate:(id)sender{

    [bar setHidden:NO];
    [datePicker setHidden:NO];

}
-(IBAction)done:(id)sender{
    [bar setHidden:YES];
    [datePicker setHidden:YES];
    
    if([Singleton connectToInternet])
        [self performSelectorInBackground:@selector(getUserProfile) withObject:nil];
    
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

}






#pragma mark-WebService Delegates
-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
    
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        
        NSLog(@"dicationary %@",[objectsDict valueForKey:@"Result"]);
        [fieldsArray removeAllObjects];
        [fieldsArray addObjectsFromArray:[objectsDict valueForKey:@"Result"]];
          //  fieldsArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        

        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[objectsDict valueForKey:@"Message"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        
        [alertView show];
    }
    
}
-(void)webServiceRequestFailed:(ASIHTTPRequest *)request{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  CreateViewController.m
//  SpotMe
//
//  Created by AliNaveed on 6/18/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "CreateViewController.h"
#import "UIActionSheet+BlocksKit.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SpotMeScreen.h"

#import "UIAlertView+BlocksKit.h"
#import <QuartzCore/QuartzCore.h>
@interface CreateViewController ()

@end

@implementation CreateViewController

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
    self.title = @"Create Account";
    
      NSLog(@"%@",SERVER_URL);
    Gender = @"Male";
    
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    activityView.hidden = YES;
    
    activityView.layer.cornerRadius = 5;
    activityView.layer.masksToBounds = YES;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)CreatAcc
{
    if(firstName.text == nil || [firstName.text isEqualToString:@""])
	    [Singleton AlertViewsFunction:EnterAllField];
	else if(lastName.text == nil || [lastName.text isEqualToString:@""])
        [Singleton AlertViewsFunction:EnterAllField];
    else if(email.text == nil || [email.text isEqualToString:@""])
        [Singleton AlertViewsFunction:EnterAllField];
    else if(![Singleton validateEmail:email.text])
        [Singleton AlertViewsFunction:CorrectEmail];
    else if(password.text == nil || [password.text isEqualToString:@""])
        [Singleton AlertViewsFunction:EnterAllField];
    else if(reEnterPassword.text == nil || [reEnterPassword.text isEqualToString:@""])                                           [Singleton AlertViewsFunction:EnterAllField];
    else if(![reEnterPassword.text isEqualToString:password.text])
        [Singleton AlertViewsFunction:PasswordMismatchs];
    else if([self AgeCalculatorFunction:dob.titleLabel.text]<14)
        [Singleton AlertViewsFunction:AgeCalculator];

 	else
	{
        
    activityView.hidden = NO;
        
    [appDelegate.webSer getSignUp:[NSString stringWithFormat: @"controller=web&action=SignUp&gym_id=%@&first_name=%@&last_name=%@&date_of_birth=%@&email=%@&password=%@&gender=%@&longitude=%@&latitude=%@&device=iphone",gymIdFromServer,firstName.text,lastName.text,dob.titleLabel.text,email.text,password.text,Gender,[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"],[[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"]]];
        [appDelegate.webSer setDelegate:self];
  }
    
}

-(int)AgeCalculatorFunction:(NSString *)myDate
{
 
     NSString *birthDate = myDate;
     NSDate *todayDate = [NSDate date];
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
     int allDays = (((time/60)/60)/24);
     int days = allDays%365;
     int years = (allDays-days)/365;
     
     NSLog(@"You live since %i years and %i days",years,days);
    
    return  years;

}


#pragma mark -
#pragma WebservicesDelegate
-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
   // NSLog(@"%@",responseStr);
}

-(void)webServiceRequestFinished:(ASIHTTPRequest *)request andResponseStr:(NSString *)responseStr ;
{
       NSLog(@"%@",responseStr);
    
    
    activityView.hidden = YES;
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    

    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
       
       
        [UIAlertView bk_showAlertViewWithTitle:@""
                                    message:[objectsDict valueForKey:@"Message"]
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil
                                    handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                    

                                        [self.navigationController popViewControllerAnimated:YES];
                                    
                                    }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[objectsDict valueForKey:@"Message"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OKay"
                                                  otherButtonTitles:nil];
        
        
        [alertView show];
    }

}
-(void)webServiceinSameFunction:(NSMutableArray *)responseStr
{
    NSLog(@"--->>>>  %@  ><<<<<<----",responseStr);
    [dataArray removeAllObjects];
    [dataArray addObjectsFromArray:responseStr];
    [Gympic reloadAllComponents];
    [Gympic selectRow:0 inComponent:0 animated:YES];
    [self ShowPickerforGym];
}
//-----------------------------------------Gym

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[dataArray objectAtIndex:row] valueForKey:@"name"];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"You selected this: %@", [dataArray objectAtIndex: row]);
    gymIdFromServer = [[[dataArray objectAtIndex:row] valueForKey:@"gym_id"] copy];
    [selectGym setTitle:[[dataArray objectAtIndex:row] valueForKey:@"name"] forState:UIControlStateNormal];
}

-(void)ShowPickerforGym
{
    activityView.hidden = YES;
    UIActionSheet *testSheet = [UIActionSheet bk_actionSheetWithTitle:@"Select Gym"];
    [testSheet bk_addButtonWithTitle:@"Select" handler:^{
        
    }];
    
    [testSheet bk_setCancelButtonWithTitle:@"" handler:^{ }];
    [testSheet bk_addButtonWithTitle:@"e" handler:^{}];
    [testSheet bk_addButtonWithTitle:@"e" handler:^{}];
    [testSheet addSubview:Gympic];
    
    
    [testSheet showInView:self.view];
}
-(IBAction)selectGym
{
    activityView.hidden = NO;
    [appDelegate.webSer
     functionValues:@"controller=web&action=GetAllGym&userid=6&sessionid=ebdc4a3005c3bc3606918d023bcfae55"];
    [appDelegate.webSer setDelegate:self];
    
    // Init the data array.
    dataArray = [[NSMutableArray alloc] init];
    Gympic = [[UIPickerView alloc] init];
    [Gympic setDataSource: self];
    [Gympic setDelegate: self];
    Gympic.showsSelectionIndicator = YES;
    Gympic.frame = CGRectMake(0, 95, 320, 500);
    Gympic.tag = 2;
    
    
    
}
-(IBAction)DOBpicker
{
    [self.view endEditing:YES];
    
    
    datepic = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 100, 320, 500)];
        datepic.tag = 1;
        datepic.datePickerMode = UIDatePickerModeDate;
    
    UIActionSheet *testSheet = [UIActionSheet bk_actionSheetWithTitle:@"Select Date"];
    [testSheet bk_addButtonWithTitle:@"Select" handler:^{
      
        NSDate *today = datepic.date;
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd"];
		NSString *Strdate = [dateFormat stringFromDate:today];
        [dob setTitle:Strdate forState:UIControlStateNormal];
        NSLog(@"%@",Strdate);

    }];

    [testSheet bk_setCancelButtonWithTitle:@"" handler:^{ }];
    [testSheet bk_addButtonWithTitle:@"e" handler:^{}];
    [testSheet bk_addButtonWithTitle:@"e" handler:^{}];
    [testSheet addSubview:datepic];

    
    [testSheet showInView:self.view];
}

- (void)pickerChanged:(id)sender
{
    NSLog(@"value: %@",[sender date]);

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


- (IBAction)MaleFemale:(id)sender
{
    if ([sender tag] == 1) {
        Gender = @"Male";
        [maleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_leftblack.png"] forState:UIControlStateNormal];
        [femaleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_rightwhite.png"] forState:UIControlStateNormal];
        
        [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [femaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    else{
        Gender = @"Female";

        [maleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_leftwhite.png"] forState:UIControlStateNormal];
        [femaleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_rightblack.png"] forState:UIControlStateNormal];
        
        [maleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
}


- (IBAction)MaleFemaleFromFAcebook:(NSString *)sender
{
    if ([sender isEqualToString:@"male"]) {
        Gender = @"Male";
        [maleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_leftblack.png"] forState:UIControlStateNormal];
        [femaleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_rightwhite.png"] forState:UIControlStateNormal];
        
        [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [femaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    else{
        Gender = @"Female";
        
        [maleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_leftwhite.png"] forState:UIControlStateNormal];
        [femaleBtn setBackgroundImage:[UIImage imageNamed:@"createaccount_genderbutton_rightblack.png"] forState:UIControlStateNormal];
        
        [maleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

///-----FAceBook

-(IBAction)facebookConnect {
    
    
    NSArray *permissionArr = [NSArray arrayWithObjects:@"email",@"user_birthday", nil];
    
    [FBSession openActiveSessionWithPermissions:permissionArr allowLoginUI:YES
                              completionHandler:^(FBSession *session,
                                                  FBSessionState status,
                                                  NSError *error) {
                                  // session might now be open.
                                  
                                  if (session.isOpen) {
                                      FBRequest *me = [FBRequest requestForGraphPath:@"me/"];
                                      [me startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                        NSDictionary<FBGraphObject> *graphObj,
                                                                        NSError *error) {
                                          //   NSLog(@"Name : %@ %@", my.first_name, my.last_name);
                                          //   selectedPhoto = my.
                                         
                                           NSLog(@"FB response : %@", [graphObj valueForKey:@"birthday"]);
                                           NSLog(@"FB response : %@", [graphObj valueForKey:@"first_name"]);
                                           NSLog(@"FB response : %@", [graphObj valueForKey:@"last_name"]);
                                           NSLog(@"FB response : %@", [graphObj valueForKey:@"email"]);
                                           NSLog(@"FB response : %@", [graphObj valueForKey:@"gender"]);                                             


                                          firstName.text = [graphObj valueForKey:@"first_name"];
                                          lastName.text = [graphObj valueForKey:@"last_name"];
                                          email.text  = [graphObj valueForKey:@"email"];
                                         [self MaleFemaleFromFAcebook:[graphObj valueForKey:@"gender"]];
                                          
                                          
                                          NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                                         [dateFormat setDateFormat:@"MM/dd/yyyy"];
                                          NSDate *date = [dateFormat dateFromString:[graphObj valueForKey:@"birthday"]];
                                          [dateFormat setDateFormat:@"yyyy-MM-dd"];
                                          NSString *Strdate = [dateFormat stringFromDate:date];
                                          [dob setTitle:Strdate forState:UIControlStateNormal];
                                          [selectGym setTitle:@"24HRGym" forState:UIControlStateNormal];

                                      }];
                                  }
                              }];
}


@end

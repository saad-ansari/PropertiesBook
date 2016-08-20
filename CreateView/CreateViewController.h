//
//  CreateViewController.h
//  SpotMe
//
//  Created by AliNaveed on 6/18/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "AppDelegate.h"
@interface CreateViewController : UIViewController<UITextFieldDelegate,WebServicesDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    IBOutlet UITextField *firstName,*lastName,*email,*password,*reEnterPassword;
    
    
    IBOutlet UIButton *maleBtn,*femaleBtn,*dob,*selectGym;
    IBOutlet UIScrollView *ScrView;
    UIDatePicker *datepic;
    
    UIPickerView *Gympic;
    
    NSString *Gender,*gymIdFromServer;
    AppDelegate *appDelegate;
    
    NSMutableArray *dataArray ;
    
    
    IBOutlet UIView *activityView;
}
@end

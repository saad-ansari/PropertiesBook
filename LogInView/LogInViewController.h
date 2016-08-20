//
//  LogInViewController.h
//  SpotMe
//
//  Created by AliNaveed on 6/18/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
@interface LogInViewController : UIViewController<UITextFieldDelegate,WebServicesDelegate>
{
    IBOutlet UITextField *Username;
	IBOutlet UITextField *pass;
    
    IBOutlet UIView *addViewTerm;

}
@end
//test@gmail.com
//123
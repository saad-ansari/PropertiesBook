//
//  MessageComposeViewController.h
//  SpotMe
//
//  Created by Muneeba Meer on 10/07/2013.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MessageComposeViewController : UIViewController<UITextFieldDelegate>{


    IBOutlet UIView	*imgBgView;
    IBOutlet UILabel *name_;
    IBOutlet UIImageView *imgView;
    IBOutlet UITextView *msgText;
    NSString *operationType;
    AppDelegate *appDelegate;
    IBOutlet UIView *replyView;
    IBOutlet UILabel *senderTitle;
    IBOutlet UITextField *replyTxt;


}
-(IBAction)close:(id)sender;
-(IBAction)replyToSender:(id)sender;
-(IBAction)deleteMsg:(id)sender;
-(IBAction)blockUser:(id)sender;
@property (nonatomic,retain)NSDictionary *senderDict;
@end

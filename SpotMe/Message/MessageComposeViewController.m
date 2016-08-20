//
//  MessageComposeViewController.m
//  SpotMe
//
//  Created by Muneeba Meer on 10/07/2013.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "MessageComposeViewController.h"
#import "JMImageCache.h"
#import "MBProgressHUD.h"
#import "UIAlertView+BlocksKit.h"
#import <BlocksKit/BlocksKit.h>
@interface MessageComposeViewController ()

@end

@implementation MessageComposeViewController
@synthesize senderDict;
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
    [[JMImageCache sharedCache] removeAllObjects];
    [self updateInterface];
    self.navigationItem.title=@"Message";
   
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
   

    // Do any additional setup after loading the view from its nib.
}
-(IBAction)close:(id)sender{


    [replyTxt resignFirstResponder];
    [replyView setHidden:YES];
}
-(IBAction)replyBtnClicked:(id)sender{

   [replyView setHidden:NO];
    
}
-(void)updateInterface{

    
    NSLog(@"sender dict %@",senderDict);
     [name_ setText:[senderDict valueForKeyPath:@"sender_info.first_name"]];
     [senderTitle setText:[senderDict valueForKeyPath:@"sender_info.first_name"]];
     imgBgView.transform = CGAffineTransformMakeRotation(-0.1);
   
    if(![[senderDict valueForKey:@"sender_info.profile_pic_url"] isKindOfClass:[NSNull class]])
     [imgView setImageWithURL:[NSURL URLWithString:[senderDict valueForKeyPath:@"sender_info.profile_pic_url"]]];
    [msgText setText:[senderDict valueForKey:@"message_text"]];


}
-(IBAction)replyToSender:(id)sender{

    if([replyTxt.text length]==0)
        return;
    else{
    
        [replyTxt resignFirstResponder];
        operationType=@"reply";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [appDelegate.webSer sendMsgToUser:[senderDict valueForKeyPath:@"sender_info.user_id"] andMsg:[[replyTxt text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [appDelegate.webSer setDelegate:self];
    
    
    }
    


}
-(IBAction)deleteMsg:(id)sender{

    if([Singleton connectToInternet])
    {
        operationType=@"delete";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [appDelegate.webSer deleteMessage:[senderDict valueForKey:@"id"]];
        [appDelegate.webSer setDelegate:self];
        
    }
    
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

    

}
-(IBAction)blockUser:(id)sender{
   
    if([Singleton connectToInternet])
    {
    
        [UIAlertView bk_showAlertViewWithTitle:@"" message:@"You want to block this user?." cancelButtonTitle:@"YES" otherButtonTitles:[NSArray arrayWithObjects:@"NO", nil] handler:^(UIAlertView *alertView, NSInteger buttonIndex){
            
            if(buttonIndex==0)
            {
                 operationType=@"block";
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [appDelegate.webSer blockUser:[senderDict valueForKeyPath:@"sender_info.user_id"]];
                [appDelegate.webSer setDelegate:self];
                
                
            }
          
            
        }];
        
    }
    
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
    
   
}
#pragma mark - WebservicesDelegate

-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        
        if([operationType isEqualToString:@"delete"])
             [  [NSNotificationCenter defaultCenter] postNotificationName:@"UPDATE" object:nil userInfo:[NSDictionary dictionaryWithObject:[senderDict valueForKey:@"id"] forKey:@"msgId"]];
        
        if([operationType isEqualToString:@"reply"])
            [UIAlertView bk_showAlertViewWithTitle:@"" message:@"Messsage Sent" cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
        
        else
        {
//        [UIAlertView bk_showAlertViewWithTitle:@"" message:[objectsDict valueForKey:@"Result"] cancelButtonTitle:@"OK" otherButtonTitles:nil handler:^(UIAlertView *alert,int index_){
//            [self.navigationController popViewControllerAnimated:YES];
//        
//        
//        }];
            
            
            [UIAlertView bk_showAlertViewWithTitle:@""
                                           message:@"text"
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil
                                           handler:^(UIAlertView *alertView, NSInteger buttonIndex){   [self.navigationController popViewControllerAnimated:YES];
                }];

        }
        
        
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  LogInViewController.m
//  SpotMe
//
//  Created by AliNaveed on 6/18/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "LogInViewController.h"
#import "CreateViewController.h"
#import "SpotMeScreen.h"
#import "UIAlertView+BlocksKit.h"
#import <BlocksKit/BlocksKit.h>
@interface LogInViewController ()

@end

@implementation LogInViewController

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
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"Login";

        // Do any additional setup after loading the view from its nib.
}

-(IBAction)CreateAccount
{
    CreateViewController *yourViewController = [[CreateViewController alloc]init];
    [self.navigationController pushViewController:yourViewController animated:YES];
}

-(IBAction)LoginVC
{
    SpotMeScreen *yourViewController = [[SpotMeScreen alloc]init];
    [self.navigationController pushViewController:yourViewController animated:YES];
    
    if([Singleton connectToInternet])
    {
    if(Username.text == nil || [Username.text isEqualToString:@""])
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter you Username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	}
	else if(pass.text == nil || [pass.text isEqualToString:@""])
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter you Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
    }
	else
	{
        
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [appDelegate.webSer getSignUp:[NSString stringWithFormat:@"controller=web&action=ValidateLogin&email=%@&password=%@&device=iphone",Username.text,pass.text]];
        [appDelegate.webSer setDelegate:self];
    }
        
    }
    else
    {
    
    
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
    
    }
}

#pragma mark -
#pragma WebservicesDelegate

-(void)webServiceRequestFinished:(NSString *)responseStr
{
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSDictionary *responseDict1 =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"])
    {
        
        [Singleton saveUserData:[[objectsDict valueForKey:@"Result"] objectAtIndex:0]];
        NSString *myStrForTerm = [[[objectsDict valueForKey:@"Result"] objectAtIndex:0] valueForKey:@"terms_agreement"];
        
        if ([myStrForTerm isEqualToString:@"1"])
        {
            SpotMeScreen *yourViewController = [[SpotMeScreen alloc]init];
            [self.navigationController pushViewController:yourViewController animated:YES];
        }
        else
            [self ViewWithModel];
        
        
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

-(void)ViewWithModel
{
    CGRect onScreenFrame = addViewTerm.frame;
    CGRect offScreenFrame = onScreenFrame;
    offScreenFrame.origin.y = self.view.bounds.size.height;
    
    addViewTerm.frame = offScreenFrame;
    [UIView beginAnimations:@"FakeModalTransition" context:nil];
    [UIView setAnimationDuration:0.5f];
    [self.view addSubview:addViewTerm];
    addViewTerm.frame = onScreenFrame;
    [UIView commitAnimations];
}
-(IBAction)agreeTerm
{
    
    NSString *ws = [NSString stringWithFormat:@"%@controller=web&action=UpdateTermsAgreement&userid=%@&sessionid=%@&device=iphone", SERVER_URL,[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"]];
    
    NSURL *url = [NSURL URLWithString:ws];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        NSLog(@"Response Data %@",responseString);
        
        SpotMeScreen *yourViewController = [[SpotMeScreen alloc]init];
        [self.navigationController pushViewController:yourViewController animated:YES];

    }];
    [request setFailedBlock:^{
        
        NSError *error = [request error];
        NSLog(@"Response Data %@",error);
    }];
    [request startAsynchronous];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

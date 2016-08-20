//
//  MessageViewController.m
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "MessageViewController.h"
#import "UIAlertView+BlocksKit.h"
#import "MessageCell.h"
#import "JMImageCache.h"
#import "MessageComposeViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    //self.title = @"Message";
     [[JMImageCache sharedCache] removeAllObjects];
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
   
    if([Singleton connectToInternet])
        [self performSelectorInBackground:@selector(getReceivedMsg) withObject:nil];
    else
    [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"UPDATE" object:nil];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    
      self.navigationController.tabBarController.navigationController.visibleViewController.navigationItem.title=@"Message";
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
}
-(void)reloadTable:(NSNotification*)Obj{


    NSLog(@"-------%@",[[Obj userInfo] valueForKey:@"msgId"]);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"id==%@", [[Obj userInfo] valueForKey:@"msgId"]];
    NSArray *matchingDicts = [msgArray filteredArrayUsingPredicate:predicate];
    NSDictionary *dict = [matchingDicts lastObject];
    NSLog(@"dict %@",dict);
    [msgArray removeObject:dict];
    [msgTable reloadData];
   
    

}
-(void)getReceivedMsg{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getAllMessages:@"receive"];
    [appDelegate.webSer setDelegate:self];


}
#pragma mark-TableView Delegates and Datasource

- (void)configureCell:(MessageCell*)cell
          atIndexPath:(NSIndexPath*)indexPath
{
    
       NSDictionary *dictionary=[msgArray objectAtIndex:indexPath.row];
       [cell setData:dictionary];

          
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [msgArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"messageCellIdentifier";
    
    MessageCell *cell;
    
    cell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    MessageComposeViewController *msgComp=[[MessageComposeViewController alloc]init];
    msgComp.senderDict=[msgArray objectAtIndex:indexPath.row];
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];

    [self.navigationController pushViewController:msgComp animated:YES];
    

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
        
        
        NSLog(@"dicationary %@",[objectsDict valueForKey:@"Result"]);
        if(msgArray==nil)
            msgArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        
        if([msgArray count]>0)
        [msgTable reloadData];
        
        
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
-(void)webServiceRequestFailed:(ASIHTTPRequest *)request{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

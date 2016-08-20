//
//  SpreadWordViewController.m
//  SpotMe
//
//  Created by Muneeba Meer on 25/08/2013.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "SpreadWordViewController.h"
#import "UIAlertView+BlocksKit.h"
@interface SpreadWordViewController ()

@end

@implementation SpreadWordViewController

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
    self.title=@"Spread The Word";
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    operationType=@"get";
    if([Singleton connectToInternet])
        [self performSelectorInBackground:@selector(getMessges) withObject:nil];
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)sendBtnClicked:(id)sender{

    [msgTxt resignFirstResponder];
    
    if([Singleton connectToInternet])
        [self performSelector:@selector(broadcastmsg) withObject:nil];
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

}
-(void)broadcastmsg{

   if([msgTxt.text length]==0)
       return;
   else{
   
        operationType=@"add";
       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [appDelegate.webSer addBroadCastMsg:[[msgTxt text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
       [appDelegate.webSer setDelegate:self];

       
   
   }


}
-(void)getMessges{
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getBroadCastMessages];
    [appDelegate.webSer setDelegate:self];

    

}
#pragma mark-TableView Delegates and Datasource

- (void)configureCell:(UITableViewCell*)cell
          atIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"values %@",[msgArray objectAtIndex:indexPath.row]);
    
    [cell.textLabel setText:[[msgArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
    
    
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
    
    UITableViewCell *cell;
    
    cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    
    return cell;
}


#pragma mark - WebservicesDelegate


-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    
     NSDictionary *responseDict1 =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        
        NSLog(@"dicationary %@",[objectsDict valueForKey:@"Result"]);
        if([operationType isEqualToString:@"get"])
        {
        if(msgArray==nil)
            msgArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        
        if([msgArray count]>0)
            [msgTable reloadData];
        }
        else{
        
            [msgTxt setText:@""];
            [UIAlertView bk_showAlertViewWithTitle:@"" message:[objectsDict valueForKey:@"Result"] cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
            
         
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
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

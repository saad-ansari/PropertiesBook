//
//  ComparePeopleViewController.m
//  SpotMeSample
//
//  Created by Muzamil on 7/9/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import "ComparePeopleViewController.h"
#import "LocateMeViewController.h"
#import "UIAlertView+BlocksKit.h"
#import "MBProgressHUD.h"
#import "ProfileViewController.h"

@interface ComparePeopleViewController ()

@end

@implementation ComparePeopleViewController
@synthesize isFromLocateMe,gymDict,isRoot;
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
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [[JMImageCache sharedCache] removeAllObjects];
    [self updateInterface];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    if(isRoot)
    {
         self.navigationController.tabBarController.navigationController.visibleViewController.navigationItem.title=@"Compare";
        [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    else{
        
        self.navigationItem.title=@"Gym Name";
        [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
        [self.navigationController setNavigationBarHidden:NO];
        
        
    }
    
}
-(void)updateInterface{

   if(isFromLocateMe)
   {
       [locateView setHidden:NO];
       [distanceView setHidden:YES];
       [peopleTable setFrame:CGRectMake(10, peopleTable.frame.origin.y-70, peopleTable.frame.size.width, peopleTable.frame.size.height+70)];
      
       if([Singleton connectToInternet])
            [self performSelectorInBackground:@selector(getMembersWithGymId) withObject:nil];
       else
       [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

      
   
   }
   else  {
       

       [locateView setHidden:YES];
       [distanceView setHidden:NO];
       
   }
    

}
-(void)getMembersWithGymId{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [appDelegate.webSer getUsersByGymId:[gymDict valueForKeyPath:@"parent_id"]];
    [appDelegate.webSer setDelegate:self];
}

-(IBAction)selectDistance:(id)sender{

    if(distancePicker==nil)
        distancePicker=[[CustomPicker alloc] initWithItems:[NSArray arrayWithObjects:@"10",@"15",@"20",@"25",@"30", nil]];
     distancePicker.delegate=self;
    
    if(![self.view.subviews containsObject:distancePicker])
        [self.view addSubview:distancePicker];


}
#pragma mark Get Records
-(void)getRecordsWithValue:(NSString*)distance{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getPeopleByDistance:distance];
    [appDelegate.webSer setDelegate:self];

}
#pragma mark-TableView Delegates and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [peopleArray count];
    
}

- (void)configureCell:(PeopleCell*)cell
          atIndexPath:(NSIndexPath*)indexPath
{
   
    NSDictionary *dictionary=[peopleArray objectAtIndex:indexPath.row];
    if (isFromLocateMe) {
        [cell setTitle:[dictionary valueForKey:@"first_name"]];
        [cell setPersonImage:[dictionary valueForKey:@"profile_pic_url"]];
    }
    else{
    
        [cell setTitle:[dictionary valueForKeyPath:@"user_info.first_name"]];
        [cell setPersonImage:[dictionary valueForKey:@"user_info.profile_pic_url"]];
    }
  
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell__";
    
    PeopleCell *cell = (PeopleCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
               
    }
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  
    ProfileViewController *profView=[[ProfileViewController alloc]init];
    profView.isRoot=NO;
    if(isFromLocateMe)
    profView.userDict=[peopleArray objectAtIndex:indexPath.row];
    else
         profView.userDict=[[peopleArray objectAtIndex:indexPath.row] valueForKey:@"user_info"];
    
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:profView animated:YES];
    
}


#pragma mark -WebservicesDelegate

-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        
        NSLog(@"dicationary %@",[objectsDict valueForKey:@"Result"]);
        if(peopleArray==nil)
            peopleArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        
      
        [peopleTable reloadData];
        
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
#pragma mark -Smart Picker Delegate
-(void) SmartUIPickerDone:(NSString*)value  {
 
    [distanceBtn setTitle:value forState:UIControlStateNormal];
    [distancePicker removeFromSuperview];
    if([Singleton connectToInternet])
    [self performSelector:@selector(getRecordsWithValue:) withObject:value afterDelay:0.001];
    else
      [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

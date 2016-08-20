//
//  ComparePeopleViewController.m
//  SpotMeSample
//
//  Created by Muzamil on 7/9/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import "ComparePeopleViewController.h"
#import "LocateMeViewController.h"
#import "JSON.h"

@interface ComparePeopleViewController ()

@end

@implementation ComparePeopleViewController
@synthesize isFromLocateMe;
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
    [self updateInterface];
    // Do any additional setup after loading the view from its nib.
}
-(void)updateInterface{

   if(isFromLocateMe)
   {
       [locateView setHidden:NO];
       [distanceView setHidden:YES];
   
   }
   else  {
       [locateView setHidden:YES];
       [distanceView setHidden:NO];
       
   }
    

}
-(void)getMembersWithGymId:(NSString*)memberId{

//http://appxone.com/Testing/SpotMe_beta/public/index.php?controller=web&action=GetAllGymLocations&parentid=2&latitude=34.1061&longitude=-117.547&distance=30&limit=all
    

}

-(IBAction)selectDistance:(id)sender{

    if(distancePicker==nil)
        distancePicker=[[CustomPicker alloc] initWithItems:[NSArray arrayWithObjects:@"35",@"40",@"100", nil]];
     distancePicker.delegate=self;
    
    if(![self.view.subviews containsObject:distancePicker])
        [self.view addSubview:distancePicker];


}
#pragma mark Get Records
-(void)getRecordsWithValue:(NSString*)distance{
   //http://appxone.com/Testing/SpotMe/public/index.php?controller=web&action=GetUsersByDistance&userid=1&sessionid=e386d942463a8d3cba17c31dc2bb864b&latitude=27.1733%09&longitude=78.0374&start=0&limit=2&distance=20
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString:[NSString stringWithFormat:@"http://appxone.com/Testing/SpotMe_beta/public/index.php?controller=web&action=GetUsersByDistance&userid=72&sessionid=bec27bcead5c52affb89938020f9d22e&latitude=27.17339&longitude=78.0374&start=0&limit=2&distance=30"]]];
    NSLog(@"%@",request);
	[request setHTTPMethod: @"GET" ];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    NSString *st=[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dictionary_=[st JSONValue];
    NSLog(@"-----%@",dictionary_);


}
#pragma mark-TableView Delegates and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}

- (void)configureCell:(PeopleCell*)cell
          atIndexPath:(NSIndexPath*)indexPath
{
   
    [cell setTitle:@"abc"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell__";
    
    PeopleCell *cell = (PeopleCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PeopleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self configureCell:cell atIndexPath:indexPath];
        
    }    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LocateMeViewController *detailView=[[LocateMeViewController alloc] init];
    [self.navigationController pushViewController:detailView animated:YES];
    
}

#pragma mark -Smart Picker Delegate
-(void) SmartUIPickerDone:(NSString*)value  {
 
    [distancePicker removeFromSuperview];
    [self performSelector:@selector(getRecordsWithValue:) withObject:value afterDelay:0.001];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

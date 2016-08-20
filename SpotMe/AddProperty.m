//
//  ViewController.m
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import "AddProperty.h"
#import "HeaderView.h"
#import "ProfileCell.h"
#import "JMImageCache.h"
#import "MBProgressHUD.h"
#import "UIAlertView+BlocksKit.h"
#import <BlocksKit/BlocksKit.h>
#import "WorkViewController.h"
#import "ImageProgressViewController.h"
@interface AddProperty ()

@end

@implementation AddProperty
@synthesize userDict,isRoot;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CollapsableTableView* tableView = (CollapsableTableView*) tbleView_;
    tableView.collapsableTableViewDelegate = self;
    updateFieldsArray=[[NSMutableArray alloc]init];
  
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataDictionary=[[NSMutableDictionary alloc] init];
    fieldsArray=[[NSMutableArray alloc]init];
    [datePicker setMaximumDate:[NSDate date]];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    
    [self update];
    

	// Do any additional setup after loading the view, typically from a nib.
}
-(void)update{

    [date_ setText:[self stringFromDate]];
}
-(NSString*)stringFromDate{
    
   return [dateFormat stringFromDate:datePicker.date];

}
-(void)viewDidAppear:(BOOL)animated{
    
    
    self.navigationController.tabBarController.navigationController.visibleViewController.navigationItem.title=@"Add Property";
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
    


    
        
}
-(void)viewWillDisappear:(BOOL)animated{

   if([Singleton connectToInternet])
    {
        if([updateFieldsArray count]>0)
        {
            if(isRoot)
                
                [self updateProfile];
        }
    }
    
    

}
-(IBAction)changeDate:(id)sender{

    [bar setHidden:NO];
    [datePicker setHidden:NO];

}
-(IBAction)done:(id)sender{
    [bar setHidden:YES];
    [datePicker setHidden:YES];
    [self update];
    NSLog(@"%@",datePicker.date);
    
    if([Singleton connectToInternet])
        [self performSelectorInBackground:@selector(getUserProfile) withObject:nil];
    
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

}

#pragma mark-IBActions
-(void)updateProfile{
    
    
    NSString *string=@"";
    
    for (int i=0; i<[updateFieldsArray count]; i++) {
        
        
        NSDictionary *fieldDict=[updateFieldsArray objectAtIndex:i];
        NSString *fieldId=[fieldDict valueForKey:@"parameter_id"];
        NSString *weight=[fieldDict valueForKey:@"no_of_weights"];
        NSString *sets=[fieldDict valueForKey:@"no_of_sets"];
        if([string length]==0)
            string=[NSString stringWithFormat:@"%@-%@-%@",fieldId,sets,weight];
        else
            string=[string stringByAppendingString:[NSString stringWithFormat:@"|%@-%@-%@",fieldId,sets,weight]];
        
        
    }
    NSLog(@"%@",string);
    [appDelegate.webSer updateWorkout:string date:datePicker.date];
    [appDelegate.webSer setDelegate:nil];
    [updateFieldsArray removeAllObjects];
    
    
}
-(void)getUserProfile{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getWorkoutByDate:datePicker.date andUserId:[userDict valueForKey:@"user_id"]];
    [appDelegate.webSer setDelegate:self];
    


}
-(void)filterData{
    
   
    [dataDictionary removeAllObjects];
    [updateFieldsArray removeAllObjects];
    NSArray *sectionArray=[fieldsArray valueForKeyPath:@"@distinctUnionOfObjects.parameter_type"] ;
    
    NSLog(@"0-------%@ ",sectionArray);
    for (int i=0; i<[sectionArray count]; i++) {
        NSString *key=[sectionArray objectAtIndex:i];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parameter_type == %@",key];
     
       
        [dataDictionary setObject:[fieldsArray filteredArrayUsingPredicate:predicate] forKey:key];
    }

     sortedKeys=[[NSArray alloc]initWithArray:[[dataDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];

      [tbleView_ reloadData];

}
#pragma mark-TableView Delegates and Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 40;


}

- (NSString*) titleForHeaderForSection:(int) section
{
    
    //NSArray *sortedKeys=[[dataDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
   // NSLog(@"all keys %@",[[dataDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    
    return [sortedKeys objectAtIndex:section];
//    switch (section)
//    {
//        case 0 : return @"First Section";
//        case 1 : return @"Second Section";
//        case 2 : return @"Third Section";
//        case 3 : return @"Fourth Section";
//        case 4 : return @"Fifth Section";
//        default : return [NSString stringWithFormat:@"Section no. %i",section + 1];
//    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self titleForHeaderForSection:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"-------section----%d",[sortedKeys count]);
           
    return [sortedKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
     // NSArray *allKeys=[dataDictionary allKeys];
       return [[dataDictionary valueForKey:[sortedKeys objectAtIndex:section]] count];
    
}
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    static NSString *headerIdentifier = @"Header__";

  //  UIView *view=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"]
    HeaderView *view=(HeaderView*)[tableView viewWithTag:section+1];
    if(view==nil)
    {
    
        view    =   [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
        [view initializeViewWithTitle:[[dataDictionary allKeys] objectAtIndex:section]];
        [view setTag:section+1];
     
        NSLog(@"view made");
    }
    
          return view;
}*/

- (void)configureCell:(ProfileCell*)cell
          atIndexPath:(NSIndexPath*)indexPath
{
     //NSArray *sortedKeys=[[dataDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    NSDictionary *dict_=[[dataDictionary valueForKey:[sortedKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
   
    [cell setDelegate:self];
    [cell setData:dict_ rootUser:isRoot];
    [cell setCellIndexPath:indexPath];
       
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSString *cellIdentifier = [NSString stringWithFormat:@"cell%d%d%@",indexPath.section,indexPath.row,dataDictionary];
    
    ProfileCell *cell = (ProfileCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
    }    
    [self configureCell:cell atIndexPath:indexPath];
    


    
    return cell;
}




#pragma mark-WebService Delegates
-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
    
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        
        NSLog(@"dicationary %@",[objectsDict valueForKey:@"Result"]);
        [fieldsArray removeAllObjects];
        [fieldsArray addObjectsFromArray:[objectsDict valueForKey:@"Result"]];
          //  fieldsArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        
        
        [self filterData];
        
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

#pragma mark- Profile Cell Delegates

-(void)setDataForUpdation:(NSString*)value andKey:(NSString*)key andIndexPath:(NSIndexPath*)indexPath{

    NSMutableDictionary *fieldDict =nil;
    NSDictionary *dict_=[[dataDictionary valueForKey:[sortedKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] ;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parameter_id == %@", [dict_ valueForKey:@"parameter_id"]];
    NSArray* filteredPersons = [updateFieldsArray filteredArrayUsingPredicate:predicate];
  
    if([filteredPersons count]>0)
    {
        
        int indexOfObj=[updateFieldsArray indexOfObject:[filteredPersons objectAtIndex:0]];
        fieldDict=[[updateFieldsArray objectAtIndex:indexOfObj] mutableCopy];
        [fieldDict setValue:value forKey:key];
        [updateFieldsArray replaceObjectAtIndex:indexOfObj withObject:fieldDict];
    }
    else{
        
        fieldDict=[dict_ mutableCopy];
        [fieldDict setValue:value forKey:key];
        [updateFieldsArray addObject:fieldDict];
                
    }
    NSLog(@"updated one %@",updateFieldsArray);

}
-(void)selectedNumberOfWeights:(NSString*)value_ atIndex:(NSIndexPath*)path{

    NSLog(@" %@ %d %d",value_,path.section,path.row);
    [self setDataForUpdation:value_ andKey:@"no_of_weights" andIndexPath:path];
    
}
-(void)selectednumberOfSets:(NSString*)value_ atIndex:(NSIndexPath*)path{
     NSLog(@" %@ %d %d",value_,path.section,path.row);
    [self setDataForUpdation:value_ andKey:@"no_of_sets" andIndexPath:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)MainPush:(id)sender
{
    mainViewForChartandImage.hidden = NO;
    mainViewForChartandImage.frame = CGRectMake(0, 360, mainViewForChartandImage.frame.size.width, mainViewForChartandImage.frame.size.height);
    
    [self.view addSubview:mainViewForChartandImage];
    [self.view bringSubviewToFront:mainViewForChartandImage];
    
    
}

-(IBAction)forImageProgress
{
    ImageProgressViewController *gridViewController = [[ImageProgressViewController alloc] initWithNibName:@"ImageProgressViewController" bundle:nil];
    [self.navigationController pushViewController:gridViewController animated:YES];
    
        mainViewForChartandImage.hidden = YES;
    
}
-(IBAction)forImageChart

{
    WorkViewController *gridViewController = [[WorkViewController alloc] initWithNibName:@"WorkViewController" bundle:nil];
    [self.navigationController pushViewController:gridViewController animated:YES];
            mainViewForChartandImage.hidden = YES;
}

@end

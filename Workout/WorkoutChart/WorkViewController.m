//
//  WorkViewController.m
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "WorkViewController.h"
#import "ProfileViewController.h"
#import "HeaderView.h"
#import "WorkViewCell.h"
#import "JMImageCache.h"
#import "MBProgressHUD.h"

#import <BlocksKit/BlocksKit.h>
#import "UIAlertView+BlocksKit.h"
#import "LineChartViewController.h"

@interface WorkViewController ()

@end


@implementation WorkViewController

@synthesize userDict,isRoot;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Singleton *single = [Singleton retriveSingleton];
    single.TrackerView = YES;

    
    CollapsableTableView* tableView = (CollapsableTableView*) tbleView_;
    tableView.collapsableTableViewDelegate = self;
    updateFieldsArray=[[NSMutableArray alloc]init];
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dataDictionary=[[NSMutableDictionary alloc] init];
    [[JMImageCache sharedCache] removeAllObjects];
    [self updateInterface];
    
    if([Singleton connectToInternet])
        [self performSelectorInBackground:@selector(getUserProfile) withObject:nil];
    
    else
        [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    
    if(isRoot)
    {
        self.navigationController.tabBarController.navigationController.visibleViewController.navigationItem.title=@"Chart Progress";
        [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    else{
        
        self.navigationItem.title=@"Chart Progress";
        [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
        [self.navigationController setNavigationBarHidden:NO];
        
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    if([Singleton connectToInternet])
    {
        if([updateFieldsArray count]>0)
        {
//            if(isRoot)
//                [self updateProfile];
        }
    }
    
    Singleton *single = [Singleton retriveSingleton];
    single.TrackerView = NO;

    
    
    
}
-(void)updateInterface{
    
    
    NSLog(@"%@",userDict);
    
    [name_ setText:[userDict valueForKey:@"first_name"]];
    imgBgView.transform = CGAffineTransformMakeRotation(-0.1);
    
    if(![[userDict valueForKey:@"profile_pic_url"] isKindOfClass:[NSNull class]])
        [imgView setImageWithURL:[NSURL URLWithString:[userDict valueForKey:@"profile_pic_url"]]];
    
    
    
}
-(void)getUserProfile{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer GetAllWorkoutParameters];
    [appDelegate.webSer setDelegate:self];
    
}
-(void)filterData{
    
    
    NSArray *sectionArray=[fieldsArray valueForKeyPath:@"@distinctUnionOfObjects.workout_category"] ;
    
    NSLog(@"0-------%@ ",sectionArray);
    for (int i=0; i<[sectionArray count]; i++) {
        
        
        NSString *key=[sectionArray objectAtIndex:i];
        NSLog(@"0--key ---%@ ",key);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"workout_category == %@",key];
        
        NSLog(@"0--predicate ---%@ ",[fieldsArray filteredArrayUsingPredicate:predicate]);
        
        [dataDictionary setObject:[fieldsArray filteredArrayUsingPredicate:predicate] forKey:key];
    }
    NSLog(@"dataDictionary %@",dataDictionary);
    
    sortedKeys=[[NSArray alloc]initWithArray:[[dataDictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    
    [tbleView_ reloadData];
    
}
#pragma mark-TableView Delegates and Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{return 40;}

- (NSString*) titleForHeaderForSection:(int) section
{
    return [sortedKeys objectAtIndex:section];
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
    return [[dataDictionary valueForKey:[sortedKeys objectAtIndex:section]] count];
}


- (void)configureCell:(WorkViewCell*)cell
          atIndexPath:(NSIndexPath*)indexPath
{
    NSDictionary *dict_=[[dataDictionary valueForKey:[sortedKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    [cell setDelegate:self];
    [cell setData:dict_ rootUser:isRoot];
    [cell setCellIndexPath:indexPath];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%d%d%@",indexPath.section,indexPath.row,dataDictionary];
    
    WorkViewCell *cell = (WorkViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[WorkViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureCell:cell atIndexPath:indexPath];
    }
    return cell;
}

#pragma mark -
#pragma mark CollapsableTableViewDelegate

- (void) collapsableTableView:(CollapsableTableView*) tableView willCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
    /// [spinner startAnimating];
}

- (void) collapsableTableView:(CollapsableTableView*) tableView didCollapseSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
    //[spinner stopAnimating];
}

- (void) collapsableTableView:(CollapsableTableView*) tableView willExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
    //[spinner startAnimating];
}

- (void) collapsableTableView:(CollapsableTableView*) tableView didExpandSection:(NSInteger) section title:(NSString*) sectionTitle headerView:(UIView*) headerView
{
    //[spinner stopAnimating];

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
        
        
        NSLog(@"dicationary %@",[objectsDict valueForKeyPath:@"Result"]);
        if(fieldsArray==nil)
            fieldsArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKeyPath:@"Result"]];
        
        
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
    [appDelegate.webSer updateProfile:string];
    [appDelegate.webSer setDelegate:nil];
    [updateFieldsArray removeAllObjects];
    
    
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
//http://www.spotme.biz/webservices/public/index.php?controller=web&action=GetWorkoutByExercise&userid=80&sessionid=743b43e1c1ff3614417d1f81b7198ca7&targetid=1&date=2013-09-13&exercise=36

-(void)selectedNumberOfWeights:(NSString*)value_ {
    
    NSLog(@" %@",value_);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parameter_id == %@",value_];
    NSLog(@"0--predicate ---%@ ",[fieldsArray filteredArrayUsingPredicate:predicate]);
    
 
    
    NSString *pareID = [[[fieldsArray filteredArrayUsingPredicate:predicate] objectAtIndex:0] valueForKey:@"parameter_id"];
    NSString *dateID  =[[[fieldsArray filteredArrayUsingPredicate:predicate] objectAtIndex:0]valueForKey:@"date_added"];
    
//    dateID = [dateID stringByReplacingOccurrencesOfString:@"(" withString:@""];
//    dateID = [dateID stringByReplacingOccurrencesOfString:@")" withString:@""];
//    
//    pareID = [pareID stringByReplacingOccurrencesOfString:@"(" withString:@""];
//    pareID = [pareID stringByReplacingOccurrencesOfString:@")" withString:@""];

    NSLog(@"0--predicate ---%@ ",pareID);
    NSLog(@" ---%@ ", dateID);

    
     LineChartViewController *detailViewController = [[LineChartViewController alloc] init];
    detailViewController.excerciseID = [pareID copy];
    detailViewController.dateValue = [dateID copy];
    [self.navigationController pushViewController:detailViewController animated:YES];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

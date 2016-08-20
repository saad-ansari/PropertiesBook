//
//  LocateMeViewController.m
//  SpotMeSample
//
//  Created by Muzamil on 7/9/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import "LocateMeViewController.h"
#import "DDAnnotation.h"
#import "UIAlertView+BlocksKit.h"
#import "ComparePeopleViewController.h"
#import "MBProgressHUD.h"
@interface LocateMeViewController ()

@end

@implementation LocateMeViewController

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
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if([Singleton connectToInternet])
     [self performSelectorInBackground:@selector(gymRecordsWithParentId:) withObject:@"1"];
   
    else
    [UIAlertView bk_showAlertViewWithTitle:@"Connectivity Issue" message:@"You are not connected to internet." cancelButtonTitle:@"OK" otherButtonTitles:nil handler:nil];

   
    pinsArray=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
  
      self.navigationController.tabBarController.navigationController.visibleViewController.navigationItem.title=@"Locate";
        [self.navigationController.tabBarController.navigationController setNavigationBarHidden:NO];
        [self.navigationController setNavigationBarHidden:YES];
       
}
#pragma mark Get Records
-(void)gymRecordsWithParentId:(NSString*)parentId{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getAllNearByGyms];
    [appDelegate.webSer setDelegate:self];

 }
-(void)setRegion{

   
    
    NSDictionary *dict=[gymsArray objectAtIndex:0];
    MKCoordinateSpan span;
    span.latitudeDelta=1.0;
    span.longitudeDelta=1.0;
    
    MKCoordinateRegion region;
    region.span=span;
    region.center=CLLocationCoordinate2DMake([[dict valueForKey:@"latitude"] floatValue], [[dict valueForKey:@"longitude"] floatValue]);
   
    [gymsMap setShowsUserLocation:YES];
    [gymsMap setRegion:region animated:YES];
    [gymsMap regionThatFits:region];

    

}
#pragma mark -mapview delegates

- (void)addAnnotationsOnMap{
   
 
       
       for(int i=0;i<[gymsArray count];i++){ 
        
        
        NSDictionary *dict=[gymsArray objectAtIndex:i];
        
        CLLocationCoordinate2D coOrd=CLLocationCoordinate2DMake([[dict valueForKey:@"latitude"] floatValue], [[dict valueForKey:@"longitude"] floatValue]);
        DDAnnotation  *place=[[DDAnnotation alloc]initWithCoordinate:coOrd addressDictionary:nil];
        [place setTitle:[NSString stringWithFormat:@"Gym %d",i]];
        [place setSubtitle:[dict valueForKey:@"address"]];
           
           
         [pinsArray addObject:[NSString stringWithFormat:@"%f%f", coOrd.latitude, coOrd.longitude]];
         [gymsMap addAnnotation:place];
        
              
    }
        
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // static identifier for map-pin for re-usablility
    if(annotation==gymsMap.userLocation)
    {
        return nil;
    }
    
    else{
        static NSString * const kAnnotationIdentifier2 = @"PinIdentifierOtherPins";
        MKPinAnnotationView *annView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: kAnnotationIdentifier2];
        
        
        if(!annView)
        {
            annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kAnnotationIdentifier2];
            annView.canShowCallout = YES;
            
            
            UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [disclosureButton setFrame:CGRectMake(0, 0, 30, 30)];
            annView.rightCalloutAccessoryView = disclosureButton;
            
            
        }
        
        
        return annView;
        
    }
     
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    
    int index=[pinsArray indexOfObject:[NSString stringWithFormat:@"%f%f",view.annotation.coordinate.latitude, view.annotation.coordinate.longitude]];
    
    NSDictionary *dict=[gymsArray objectAtIndex:index];
    NSLog(@"dict %@",dict);
    
    ComparePeopleViewController *compareView=[[ComparePeopleViewController alloc]init];
    compareView.gymDict=dict;
    compareView.isRoot=NO;
    compareView.isFromLocateMe=YES;
    
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:compareView animated:YES];
    
    
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
        if(gymsArray==nil)
         gymsArray=[[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        
        if([gymsArray count]>0)
        {
        [self setRegion];
       [self performSelector:@selector(addAnnotationsOnMap) withObject:nil afterDelay:0.5];
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

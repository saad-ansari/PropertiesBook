//
//  ComparePeopleViewController.h
//  SpotMeSample
//
//  Created by Muzamil on 7/9/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
#import "PeopleCell.h"
#import "AppDelegate.h"
#import "JMImageCache.h"


@interface ComparePeopleViewController : UIViewController{


    CustomPicker *distancePicker;
    IBOutlet UITableView *peopleTable;
    NSMutableArray *peopleArray;
    IBOutlet UIView *distanceView,*locateView;
    AppDelegate *appDelegate;
    IBOutlet UIButton *distanceBtn;
    
}
@property (nonatomic,assign)BOOL isRoot;
@property(nonatomic,assign)BOOL isFromLocateMe;
@property(nonatomic,strong)NSDictionary *gymDict;
-(IBAction)selectDistance:(id)sender;
-(void)getMembersWithGymId;
@end

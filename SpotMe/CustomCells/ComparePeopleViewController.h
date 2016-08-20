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


@interface ComparePeopleViewController : UIViewController{


    CustomPicker *distancePicker;
    IBOutlet UITableView *peopleTable;
    NSMutableArray *peopleArray;
    IBOutlet UIView *distanceView,*locateView;
    
}
@property(nonatomic,assign)BOOL isFromLocateMe;
-(IBAction)selectDistance:(id)sender;
@end

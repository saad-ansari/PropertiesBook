//
//  ViewController.h
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CollapsableTableView.h"
#import "CollapsableTableViewDelegate.h"

@interface ProfileViewController : UIViewController<CollapsableTableViewDelegate>
{


    IBOutlet UITableView *tbleView_;
    NSMutableArray *fieldsArray;
    NSMutableDictionary *dataDictionary;
    IBOutlet UIView	*imgBgView;
    IBOutlet UILabel *name_;
    IBOutlet UIImageView *imgView;
    AppDelegate *appDelegate;
    NSArray *sortedKeys;
    NSMutableArray *updateFieldsArray;
    
    IBOutlet UIView *mainViewForChartandImage;
    BOOL ImageZoome;
    UIButton *forZoomingIMage;
   
}
@property(nonatomic,assign)BOOL isRoot;
@property(nonatomic,retain)NSDictionary *userDict;
-(IBAction)updateProfile:(id)sender;
-(IBAction)forMessage;
-(IBAction)forVideos;
@end

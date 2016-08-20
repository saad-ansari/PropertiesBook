//
//  WorkViewController.h
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CollapsableTableView.h"
#import "CollapsableTableViewDelegate.h"
#import "WorkViewCell.h"


//---


@interface WorkViewController : UIViewController<CollapsableTableViewDelegate,WebServicesDelegate,WorkViewCellDelegate>
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
    
    NSMutableDictionary *data;
    //NSArray *data;
    
    NSMutableArray *months;
    NSMutableArray *dataKeys;
    
//    SF1CrosshairTooltip *customTooltip;
    
    UIView *toolTipD;
    
    NSMutableArray * sortedData;
    
}
@property(nonatomic,assign)BOOL isRoot;
@property(nonatomic,retain)NSDictionary *userDict;

-(IBAction)updateProfile:(id)sender;
@end

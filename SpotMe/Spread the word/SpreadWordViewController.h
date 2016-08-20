//
//  SpreadWordViewController.h
//  SpotMe
//
//  Created by Muneeba Meer on 25/08/2013.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SpreadWordViewController : UIViewController
{

    IBOutlet UITextField *msgTxt;
    IBOutlet UITableView * msgTable;
    NSMutableArray *msgArray;
    NSString *operationType;
    AppDelegate *appDelegate;;
}

@end

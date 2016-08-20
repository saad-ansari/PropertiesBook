//
//  MessageViewController.h
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCell.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface MessageViewController : UIViewController
{


    IBOutlet UITableView *msgTable;
    NSMutableArray *msgArray;
    AppDelegate *appDelegate;
}
-(void)reloadTable:(id)Obj;
@end

//
//  CollapsableTableViewFooterViewController.h
//  CollapsableTableView
//
//  Created by Bernhard Häussermann on 2012/12/15.
//
//

#import <UIKit/UIKit.h>

@interface CollapsableTableViewFooterViewController : UIViewController
{
    IBOutlet UILabel* titleLabel;
}

@property (nonatomic,retain) NSString* titleText;
@property (nonatomic,readonly) UILabel* titleLabel;

@end

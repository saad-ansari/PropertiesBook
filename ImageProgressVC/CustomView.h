//
//  CustomView.h
//  SpotMe
//
//  Created by Ali Naveed on 9/23/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomViewDelegate <NSObject>

-(void)buttonIdwithString:(NSDictionary *)mystr;
@end

@interface CustomView : UIView
{
    IBOutlet UIImageView *commentPostField ;
    IBOutlet UIButton *commentPostBtn ;
    IBOutlet UILabel *datelbl ;
    NSDictionary *mydict;
}

@property(nonatomic, retain) UIImageView *commentPostField ;
@property(nonatomic, retain) UIButton *commentPostBtn ;
@property(nonatomic, retain)UILabel *datelbl ;
@property (nonatomic,retain)NSDictionary *mydict;
@property(nonatomic, retain) id delegate ;
-(IBAction)forDeleteBtn;

@end

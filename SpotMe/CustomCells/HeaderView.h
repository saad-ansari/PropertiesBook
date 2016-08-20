//
//  HeaderView.h
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
{

    IBOutlet UILabel *headerlbl;

}
-(void)initializeViewWithTitle:(NSString*)headerTitle;

@end

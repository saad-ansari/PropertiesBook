//
// PeopleCell.h

//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMImageCache.h"
@interface PeopleCell : UITableViewCell  {
	
	IBOutlet UIView		*subview,*imgBgView;
    IBOutlet UILabel *name_;
    IBOutlet UIImageView *imgView;


	
}

-(void)setTitle:(NSString*)text;
-(void)setPersonImage:(NSString*)pic_url;


@end




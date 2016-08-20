//
// ShareCell.h

//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MessageCell : UITableViewCell  {
	
	IBOutlet UIView		*subview,*imgBgView;
    IBOutlet UILabel *name_;
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *msgText,*msgDate;
	
	
}

-(void)setData:(NSDictionary*)senderDict;


@end




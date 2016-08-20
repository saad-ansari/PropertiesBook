//
//  ShareCell.m
//  MyTalk
//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
		[[NSBundle mainBundle] loadNibNamed:@"PeopleCell" owner:self options:nil];
        imgBgView.transform = CGAffineTransformMakeRotation(-0.1);
		[self.contentView addSubview:subview];
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitle:(NSString*)text{

    [name_ setText:text];
    
    
}
-(void)setPersonImage:(NSString*)pic_url{

    if(![pic_url isKindOfClass:[NSNull class]])

    [imgView setImageWithURL:[NSURL URLWithString:pic_url]];

    
}
- (void)dealloc {
	
    subview=nil;
  
    [super dealloc];
}


@end

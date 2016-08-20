//
//  ShareCell.m
//  MyTalk
//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageCell.h"
#import "JMImageCache.h"

@implementation MessageCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
		[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil];
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
-(void)setData:(NSDictionary*)senderDict{

    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *serverDate=[dateFormat dateFromString:[senderDict valueForKey:@"date_sent"]];
    NSTimeInterval interval_=[[Singleton getServerTime] doubleValue];
    NSDate *now =[serverDate dateByAddingTimeInterval:interval_];

    NSString *dateStr=[dateFormat stringFromDate:now];
    NSArray *dateTimeArray=[dateStr componentsSeparatedByString:@" "];
    
    if([now compare:[NSDate date]]==NSOrderedSame)
        [msgDate setText:[NSString stringWithFormat:@"%@",[dateTimeArray objectAtIndex:1]]];
    else
  
    [msgDate setText:[NSString stringWithFormat:@"%@",[dateTimeArray objectAtIndex:0]]];
  
    [name_ setText:[senderDict valueForKeyPath:@"sender_info.first_name"]];
       
    if(![[senderDict valueForKey:@"sender_info.profile_pic_url"] isKindOfClass:[NSNull class]])
        [imgView setImageWithURL:[NSURL URLWithString:[senderDict valueForKeyPath:@"sender_info.profile_pic_url"]]];
    [msgText setText:[senderDict valueForKey:@"message_text"]];
    

}

- (void)dealloc {
	
    subview=nil;
    
    [super dealloc];
}



@end

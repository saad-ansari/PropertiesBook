//
//  ShareCell.m
//  MyTalk
//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WorkViewCell.h"

@implementation WorkViewCell
@synthesize delegate,cellIndexPath,setID;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
		[[NSBundle mainBundle] loadNibNamed:@"WorkViewCell" owner:self options:nil];
        picker=[[CustomPicker alloc] initWithItems:nil ];
        picker.delegate=self;
		[self.contentView addSubview:subview];
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(NSDictionary*)dict rootUser:(BOOL)user;{

    [titleLbl setText:[dict valueForKey:@"name"]];
   [setBtn setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"no_of_sets"]] forState:UIControlStateNormal];
    [weightBtn setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"no_of_weights"]] forState:UIControlStateNormal];
    minSet=[[dict valueForKey:@"set_start"] intValue];
    maxSet=[[dict valueForKey:@"set_end"] intValue];
    minWeight=[[dict valueForKey:@"weight_start"] intValue];
    maxWeight=[[dict valueForKey:@"weight_end"] intValue];

    setID = [dict valueForKey:@"parameter_id"];
    NSLog(@"------dictionary %@",dict);

}

-(NSString*)getWeight{

    return weightBtn.titleLabel.text;

}
-(NSString*)getSet{

     return setBtn.titleLabel.text;

}

-(IBAction)selectWeights:(id)sender{

    if([delegate respondsToSelector:@selector(selectedNumberOfWeights:)])
    [delegate selectedNumberOfWeights:setID];

   
}
- (void)dealloc {
	
    subview=nil;
    titleLbl=nil;
    cellIndexPath=nil;
    [picker release];
    picker=nil;
    [delegate release];
    delegate=nil;
    
    [super dealloc];
}


@end

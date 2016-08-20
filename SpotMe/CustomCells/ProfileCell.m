//
//  ShareCell.m
//  MyTalk
//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell
@synthesize delegate,cellIndexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		
		[[NSBundle mainBundle] loadNibNamed:@"ProfileCell" owner:self options:nil];
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

    [titleLbl setText:[dict valueForKey:@"parameter_name"]];
   [setBtn setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"no_of_sets"]] forState:UIControlStateNormal];
    [weightBtn setTitle:[NSString stringWithFormat:@"%@",[dict valueForKey:@"no_of_weights"]] forState:UIControlStateNormal];
    minSet=[[dict valueForKey:@"set_start"] intValue];
    maxSet=[[dict valueForKey:@"set_end"] intValue];
    minWeight=[[dict valueForKey:@"weight_start"] intValue];
    maxWeight=[[dict valueForKey:@"weight_end"] intValue];

    if(!user)
    {
    
        [setBtn setUserInteractionEnabled:NO];
        [weightBtn setUserInteractionEnabled:NO];
    }
    NSLog(@"------dictionary %@",dict);

}

-(NSString*)getWeight{

    return weightBtn.titleLabel.text;

}
-(NSString*)getSet{

     return setBtn.titleLabel.text;

}

-(IBAction)selectWeights:(id)sender{

    type=0;
    UIViewController *senderView=(UIViewController*)delegate ;
    if([ senderView.view.subviews containsObject:picker])
        [picker removeFromSuperview];
    [picker setItems:[self getArray:minWeight andMax:maxWeight]];
    [[(UIViewController*)delegate view] addSubview:picker];
    
   
}
-(IBAction)selectSets:(id)sender{
    

    type=1;
    UIViewController *senderView=(UIViewController*)delegate ;
    if([ senderView.view.subviews containsObject:picker])
        [picker removeFromSuperview];
    [picker setItems:[self getArray:minSet andMax:maxSet]];
    [[(UIViewController*)delegate view] addSubview:picker];

    
}

#pragma mark -Smart Picker Delegate
-(void) SmartUIPickerDone:(NSString*)value  {
    
    if(type==0)
    {
    [weightBtn setTitle:value forState:UIControlStateNormal];
   // if([delegate respondsToSelector:@selector(selectedNumberOfWeights::)])
        [delegate selectedNumberOfWeights:value atIndex:cellIndexPath];
    //}
    }
    else if(type==1)
    {
         [setBtn setTitle:value forState:UIControlStateNormal];
       // if([delegate respondsToSelector:@selector(selectednumberOfSets:atIndex::)])
            [delegate selectednumberOfSets:value atIndex:cellIndexPath];

    
    }
    [picker removeFromSuperview];

}
-(NSMutableArray*)getArray:(int)min andMax:(int)max{

    NSMutableArray *numberArray=[NSMutableArray array];
    for (int i=min; i<=max; i++) {
        
        [numberArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    return  numberArray;


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

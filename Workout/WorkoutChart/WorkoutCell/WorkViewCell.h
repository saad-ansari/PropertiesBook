//
// ShareCell.h

//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
@protocol WorkViewCellDelegate <NSObject>

-(void)selectedNumberOfWeights:(NSString*)value_ ;

@end
@interface WorkViewCell : UITableViewCell  {
	
	IBOutlet UIView		*subview;
    IBOutlet UILabel *titleLbl;
    NSIndexPath *cellIndexPath;
    CustomPicker *picker;
    int type;
    IBOutlet UIButton *weightBtn,*setBtn;
    int minSet,maxSet,minWeight,maxWeight;
    
    NSString *setID;
      	
}
@property(nonatomic,retain) id <WorkViewCellDelegate> delegate;
@property(nonatomic,retain) NSIndexPath *cellIndexPath;
@property(nonatomic,retain)    NSString *setID;
-(void)setData:(NSDictionary*)dict rootUser:(BOOL)user;
-(IBAction)selectWeights:(id)sender;
-(IBAction)selectSets:(id)sender;
-(NSMutableArray*)getArray:(int)min andMax:(int)max;
-(NSString*)getWeight;
-(NSString*)getSet;



@end




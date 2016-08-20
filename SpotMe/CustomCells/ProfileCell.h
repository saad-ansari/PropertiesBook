//
// ShareCell.h

//
//  Created by Samson Peter on 6/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
@protocol ProfileCellDelegate <NSObject>

-(void)selectedNumberOfWeights:(NSString*)value_ atIndex:(NSIndexPath*)path;
-(void)selectednumberOfSets:(NSString*)value_ atIndex:(NSIndexPath*)path;

@end
@interface ProfileCell : UITableViewCell  {
	
	IBOutlet UIView		*subview;
    IBOutlet UILabel *titleLbl;
    NSIndexPath *cellIndexPath;
    CustomPicker *picker;
    int type;
    IBOutlet UIButton *weightBtn,*setBtn;
    int minSet,maxSet,minWeight,maxWeight;
      	
}
@property(nonatomic,retain) id <ProfileCellDelegate> delegate;
@property(nonatomic,retain) NSIndexPath *cellIndexPath;
-(void)setData:(NSDictionary*)dict rootUser:(BOOL)user;
-(IBAction)selectWeights:(id)sender;
-(IBAction)selectSets:(id)sender;
-(NSMutableArray*)getArray:(int)min andMax:(int)max;
-(NSString*)getWeight;
-(NSString*)getSet;



@end




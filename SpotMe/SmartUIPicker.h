//
//  SmartUIPicker.h
//  FittingRoom
//
//  Created by Blue Moon on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SmartUIPickerDelegate <NSObject>

-(void) SmartUIPickerDone:(NSString*)value ;
-(void) SmartUIPickerValueChanged:(NSString*)value ;

@end

@interface SmartUIPicker : UIView <UIPickerViewDataSource, UIPickerViewDelegate> {
    id delegate ;
    NSArray *items ;
    UIPickerView *picker ;
    NSString *selectedValue;
}

@property(nonatomic, retain) id delegate ;
@property(nonatomic, retain) NSArray *items ;

-(id) initWithItems:(NSArray *)array ;
-(void) resetItems:(NSMutableArray *)newItems ;

@end

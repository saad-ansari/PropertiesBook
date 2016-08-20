//
//  SmartUIPicker.m
//  FittingRoom
//
//  Created by Blue Moon on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SmartUIPicker.h"
#import "Food.h"

@implementation SmartUIPicker
@synthesize delegate ;
@synthesize items ;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int height = 255;
        
        //create new view
        self.frame = frame ;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        //add toolbar
        UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, 320, 44)];
        toolbar.barStyle = UIBarStyleBlack;
        
        //add button
        UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(SmartUIPickerDone)];
        toolbar.items = [NSArray arrayWithObjects:infoButtonItem, nil];
        
        //add date picker
        picker = [[UIPickerView alloc] init];
        picker.hidden = NO;
        picker.frame = CGRectMake(0, 40, 320, 216);
        [picker setDelegate:self];
        [picker setShowsSelectionIndicator:YES];
        
        [self addSubview:picker];
        
        //add popup view
        [self addSubview:toolbar];
        //        [self.view addSubview:newView];
        
        //animate it onto the screen
        //        CGRect temp = self.frame;
        //        temp.origin.y = CGRectGetMaxY(self.view.bounds);
        //        self.frame = temp;
        //        [UIView beginAnimations:nil context:nil];
        //        temp.origin.y -= height;
        //        self.frame = temp;
        //        [UIView commitAnimations];
        self.delegate = self ;
    }
    return self;
}

-(void) resetItems:(NSMutableArray *)newItems ;{
    self.items = newItems ;
    [picker reloadAllComponents];
}

-(id) initWithItems:(NSArray *)array ;{
    self.items = array ;
    return [self init];
}

-(id) init {
    int y;
    if(IS_IPHONE_5)
        y=226;
    else
        y=180;
        
    int height = 255;
    CGRect frame = CGRectMake(0, y, 320, height);
    return [self initWithFrame:frame];
}

-(void) donePressed {
    if([delegate respondsToSelector:@selector(SmartUIPickerDone:)]){
        [delegate SmartUIPickerDone];
    }
}

-(void)setItems:(NSArray *)_items{
    items = _items ;
    [picker reloadAllComponents];
}

#pragma -
#pragma UIPickerViewDelegate ;

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1 ;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [items count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
 
    NSString *rowText = [NSString stringWithFormat:@"%@ - %@",(Food*)[[items objectAtIndex:row] itemName],(Food*)[[items objectAtIndex:row] calories]] ;

    UILabel *label = nil ;
    if(view==nil){
        view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 320, 25)];
    }
    else {
        label = [view.subviews objectAtIndex:0];
    }


    [label setBackgroundColor:[UIColor clearColor]];
    UIColor *textColor = [UIColor colorWithRed:0.15 green:0.25 blue:0.5 alpha:1.0];
    [label setTextColor:textColor];
    [label setText:rowText];
    [label setNumberOfLines:0];
    [label setLineBreakMode:UILineBreakModeWordWrap];
    [label setAdjustsFontSizeToFitWidth:NO];
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    //    [label setTextAlignment:UITextAlignmentCenter];
    label.shadowColor = [UIColor whiteColor];
//    label.shadowOffset = CGSizeMake(0, 1);
    
    [view addSubview:label];
    
    return view ;
    
}

/*
 -(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 return [items objectAtIndex:row];
 }
 */

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    selectedValue=[NSString stringWithFormat:@"%@ - %@",(Food*)[[items objectAtIndex:row] itemName],(Food*)[[items objectAtIndex:row] calories]];
  /*  if([delegate respondsToSelector:@selector(SmartUIPickerValueChanged:)]){
        [delegate SmartUIPickerValueChanged:[items objectAtIndex:row]];
    }*/
}

-(void) SmartUIPickerDone  {
    
    
    
    if([delegate respondsToSelector:@selector(SmartUIPickerDone:)]){
        
        [delegate SmartUIPickerDone:selectedValue];
        [self removeFromSuperview];
    }
    else {
        [self removeFromSuperview];
    }
}

@end

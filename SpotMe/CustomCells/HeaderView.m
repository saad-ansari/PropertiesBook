//
//  HeaderView.m
//  SpotMeSample
//
//  Created by Muzamil on 7/8/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initializeViewWithTitle:(NSString*)headerTitle{

    [headerlbl setText:headerTitle];
 

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

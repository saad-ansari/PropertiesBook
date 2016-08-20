//
//  CustomView.m
//  SpotMe
//
//  Created by Ali Naveed on 9/23/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@end

@implementation CustomView

@synthesize commentPostBtn, commentPostField,datelbl,delegate,mydict;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)forDeleteBtn
{

        if([delegate respondsToSelector:@selector(buttonIdwithString:)]){
            [delegate buttonIdwithString:mydict];
        }
}
@end

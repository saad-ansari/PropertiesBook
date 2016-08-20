//
//  NRGridViewCell.m
//
//  Created by Louka Desroziers on 05/01/12.

/***********************************************************************************
 *
 * Copyright (c) 2012 Louka Desroziers
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 ***********************************************************************************
 *
 * Referencing this project in your AboutBox is appreciated.
 * Please tell me if you use this class so we can cross-reference our projects.
 *
 ***********************************************************************************/

#import "NRGridViewCell.h"
#import "NRGridConstants.h"

@interface NRGridViewCellSelectionBackgroundView : UIView
@end
@implementation NRGridViewCellSelectionBackgroundView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setOpaque:NO];
        [self setContentMode:UIViewContentModeRedraw];
    }
   
    return self;
}
- (void)drawRect:(CGRect)rect
{    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat cornerRadius = 5.;
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:[self bounds] 
                                                           cornerRadius:cornerRadius];
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, [roundedPath CGPath]);
    CGContextClip(ctx);

    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();

    CGFloat locations[2] = {0.0, 1.0};
    CGColorRef top, bottom;
    top = [[UIColor colorWithRed:108./255. green:178./255. blue:226./255. alpha:1.] CGColor];
    bottom = [[UIColor colorWithRed:59./255. green:136./255. blue:206./255. alpha:1.] CGColor];
    
    CGFloat components[8] = {CGColorGetComponents(top)[0],CGColorGetComponents(top)[1],CGColorGetComponents(top)[2],CGColorGetComponents(top)[3] 
        ,CGColorGetComponents(bottom)[0],CGColorGetComponents(bottom)[1],CGColorGetComponents(bottom)[2],CGColorGetComponents(bottom)[3]};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(spaceRef, components, locations, (size_t)2);
    CGContextDrawLinearGradient(ctx, gradient, [self bounds].origin, CGPointMake(CGRectGetMinX([self bounds]), CGRectGetMaxY([self bounds])), (CGGradientDrawingOptions)NULL);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(spaceRef);
    
    CGContextRestoreGState(ctx);

    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 1);
    CGPathRef translatedPath = CGPathCreateCopyByTransformingPath([roundedPath CGPath], &translation);

    CGContextSaveGState(ctx);
    CGContextBeginTransparencyLayer(ctx, NULL);
    
    CGContextAddPath(ctx, [roundedPath CGPath]);
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:95./255. green:165./255. blue:220./255. alpha:1.] CGColor]);
    CGContextFillPath(ctx);
    
    CGContextAddPath(ctx, translatedPath);
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextFillPath(ctx);
    
    CGPathRelease(translatedPath);
    CGContextEndTransparencyLayer(ctx);
    CGContextRestoreGState(ctx);

    
    CGContextSaveGState(ctx);
    CGContextBeginTransparencyLayer(ctx, NULL);

    CGContextAddPath(ctx, [roundedPath CGPath]);
    CGContextSetFillColorWithColor(ctx, [[[UIColor whiteColor] colorWithAlphaComponent:0.15] CGColor]);
    CGContextFillPath(ctx);
    
    translation = CGAffineTransformMakeTranslation(0, 2);
    translatedPath = CGPathCreateCopyByTransformingPath([roundedPath CGPath], &translation);
    
    CGContextAddPath(ctx, translatedPath);
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextFillPath(ctx);
    
    CGPathRelease(translatedPath);
    CGContextEndTransparencyLayer(ctx);
    CGContextRestoreGState(ctx);
    
    
    CGContextSaveGState(ctx);
    CGContextBeginTransparencyLayer(ctx, NULL);
    
    CGContextAddPath(ctx, [roundedPath CGPath]);
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:55./255. green:124./255. blue:191./255. alpha:1.] CGColor]);
    CGContextFillPath(ctx);
    
    translation = CGAffineTransformMakeTranslation(0, -1);
    translatedPath = CGPathCreateCopyByTransformingPath([roundedPath CGPath], &translation);
    
    CGContextAddPath(ctx, translatedPath);
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextFillPath(ctx);
    
    CGPathRelease(translatedPath);
    CGContextEndTransparencyLayer(ctx);
    CGContextRestoreGState(ctx);

}

@end

@interface NRGridViewCell()
- (void)__commonInit;

@property (nonatomic, readonly) BOOL needsRelayout;

@end

@implementation NRGridViewCell
@dynamic needsRelayout;

@synthesize reuseIdentifier = _reuseIdentifier;

@synthesize contentView = _contentView;

@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel, detailedTextLabel = _detailedTextLabel;

@synthesize selectionBackgroundView = _selectionBackgroundView;
@synthesize backgroundView = _backgroundView,ViewButton = _ViewButton;

@synthesize selected = _selected, highlighted = _highlighted;

- (void)__commonInit 
{
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [_contentView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_contentView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        NSAssert(NO, 
                 @"%@: can't be instanciated using -initWithFrame. Please use -initWithReusableIdentifier", 
                 NSStringFromClass([self class]));
        
    }
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        NSAssert(reuseIdentifier != nil, 
                 @"%@: reusableIdentifier cannot be nil", 
                 NSStringFromClass([self class]));
        
        [self __commonInit];
        _reuseIdentifier = [reuseIdentifier copy];
    }
    return self;
}

#pragma mark -

- (void)prepareForReuse
{
    [self setSelected:NO];
    [self setHighlighted:NO];
}


#pragma mark - Getters

- (BOOL)needsRelayout
{
    return ([self superview] != nil);
}

- (UIView *)selectionBackgroundView
{
    return nil;
}

- (UIImageView*)imageView
{
    if(_imageView == nil)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView setClipsToBounds:YES];
        
        [_imageView addObserver:self 
                     forKeyPath:@"image" 
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:nil];
        
        [[self contentView] addSubview:_imageView];
    }
    return [[_imageView retain] autorelease];
}

- (void)setButtonForView
{
    UIButton *mybtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [mybtn setImage:[UIImage imageNamed:@"delete_butt.png"] forState:UIControlStateNormal];
    mybtn.frame = CGRectMake(0, 0, 200, 200);
    [mybtn addTarget:self action:@selector(mybtn:) forControlEvents:UIControlEventTouchUpInside];
    [[self contentView]  addSubview:mybtn];
    
    [self insertSubview:mybtn aboveSubview:[self imageView]];


}


#pragma mark - Setters

- (void)setBackgroundView:(UIView *)backgroundView{}
- (void)setSelectionBackgroundView:(UIView *)selectionBackgroundView{}
- (void)setSelected:(BOOL)selected{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if(_selected != selected)
    {
        _selected = selected;
        
        void (^selectionBlock)() = ^{

            for(UIView *subview in [[self contentView] subviews])
            {
                if([subview respondsToSelector:@selector(setHighlighted:)])
                    [(id)subview setHighlighted:([self isHighlighted] || selected)];
            }
            
            [[self selectionBackgroundView] setAlpha:([self isHighlighted] || selected)];
        };
        
        if(animated)
        {
            [UIView animateWithDuration:_kNRGridDefaultAnimationDuration 
                             animations:^{
                                 selectionBlock();
                             }];
        }else{
            selectionBlock();
        }
    }
}
- (void)setHighlighted:(BOOL)highlighted{}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if(_highlighted != highlighted)
    {
        _highlighted = highlighted;
        
        void (^highlightBlock)() = ^{

            for(UIView *subview in [[self contentView] subviews])
            {
                if([subview respondsToSelector:@selector(setHighlighted:)])
                    [(id)subview setHighlighted:(highlighted || [self isSelected])];
            }
            
            [[self selectionBackgroundView] setAlpha:(highlighted || [self isSelected])];
        };
        
        if(animated)
        {
            [UIView animateWithDuration:_kNRGridDefaultAnimationDuration 
                             animations:^{
                                 highlightBlock();
                             }];
        }else{
            highlightBlock();
        }
    }
}

#pragma mark - Layout
static CGSize const _kNRGridViewCellLayoutPadding = {5,5};
static CGSize const _kNRGridViewCellLayoutSpacing = {5,5};

- (void)layoutSubviews
{
    CGRect cellBounds = [self bounds];
    [[self selectionBackgroundView] setFrame:cellBounds];
    [[self backgroundView] setFrame:cellBounds];
    [[self imageView] setFrame:CGRectMake(8, 10, 80, 80)];

//    [self setButtonForView];
}
-(void)mybtn:(id)sender
{
    NSLog(@"%d",[sender tag]);
}
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"image"] && object == [self imageView])
    {
        UIImage *old, *new;
        old = [change objectForKey:NSKeyValueChangeOldKey];
        new = [change objectForKey:NSKeyValueChangeNewKey];
        
        
        if( ((NSNull*)old == [NSNull null] || (NSNull*)new == [NSNull null])  
           || CGSizeEqualToSize([old size], [new size]) == NO)
            [self setNeedsLayout];
    }
}

#pragma mark - Memory

- (void)dealloc
{    
    [_imageView removeObserver:self forKeyPath:@"image"];
    [_contentView release];
    [_reuseIdentifier release];
    
    [_imageView release];
    [_textLabel release];
    [_detailedTextLabel release];
    
    [_selectionBackgroundView release];
    [_backgroundView release];
    
    [super dealloc];
}

@end

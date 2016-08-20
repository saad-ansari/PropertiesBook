/**
 * Copyright (c) 2011 Muh Hon Cheng
 * Created by honcheng on 28/4/11.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the 
 * "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, sublicense, and/or sell copies of the Software, and to 
 * permit persons to whom the Software is furnished to do so, subject 
 * to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT 
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR 
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
 * IN CONNECTION WITH THE SOFTWARE OR 
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author 		Muh Hon Cheng <honcheng@gmail.com>
 * @copyright	2011	Muh Hon Cheng
 * @version
 * 
 */

#import "LineChartViewController.h"
#import "JSONKit.h"
#import "Singleton.h"
@implementation LineChartViewController
@synthesize dateValue,excerciseID;
- (id)init
{
	self = [super init];
	if (self)
	{
		}
	return self;
}

-(void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [self setTitle:@"Line Chart"];
    
    _lineChartView = [[PCLineChartView alloc] initWithFrame:CGRectMake(10,10,[self.view bounds].size.width-20,[self.view bounds].size.height-20)];
    [_lineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _lineChartView.minValue = -40;
    _lineChartView.maxValue = 100;
    [self.view addSubview:_lineChartView];
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetWorkoutByExercise&userid=%@&sessionid=%@&targetid=1&&date=%@&exercise=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],self.dateValue,self.excerciseID];
    
//    NSLog(@"subPath  %@",subPath);
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    urls = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"subPath  %@",urls);
    NSString *jsonString =[NSString stringWithContentsOfURL:[NSURL URLWithString:urls] encoding:NSUTF8StringEncoding error:nil];
    
    
    NSDictionary *sampleInfo = [jsonString objectFromJSONString];
    NSLog(@"jsong string %@",sampleInfo);
    NSLog(@"jsong string %@",[[sampleInfo valueForKey:@"Data"] valueForKey:@"Result"]);
    
    NSMutableArray *No_ofset = [[NSMutableArray alloc] init];
    NSMutableArray *No_ofweight = [[NSMutableArray alloc] init];
    NSMutableArray *No_oflabel = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<[[[sampleInfo valueForKey:@"Data"] valueForKey:@"Result"] count]; i++)
    {
        NSString *noOfSet = [[[[sampleInfo valueForKey:@"Data"] valueForKey:@"Result"] objectAtIndex:i] valueForKey:@"no_of_sets"];
        [No_ofset addObject:noOfSet];
        
        NSString *noOfWeight = [[[[sampleInfo valueForKey:@"Data"] valueForKey:@"Result"] objectAtIndex:i] valueForKey:@"no_of_weights"];
        [No_ofweight addObject:noOfWeight];
        
        NSString *noOflbl= [[[[sampleInfo valueForKey:@"Data"] valueForKey:@"Result"] objectAtIndex:i] valueForKey:@"date_workout"];
        if (![No_oflabel containsObject:noOflbl])
        {
            [No_oflabel addObject:noOflbl];
        }
        
    }
    
    
    NSMutableArray *components = [NSMutableArray array];
    
    PCLineChartViewComponent *component = [[PCLineChartViewComponent alloc] init];
    [component setTitle:@"data"];
    NSArray *array = [NSArray arrayWithArray:No_ofset];
    
    [component setPoints:array];
    [component setShouldLabelValues:NO];
    [component setColour:PCColorYellow];
    
    [components addObject:component];
    
    PCLineChartViewComponent *component1 = [[PCLineChartViewComponent alloc] init];
    [component1 setTitle:@"data"];
    NSArray *array1 = [NSArray arrayWithArray:No_ofweight];
    
    [component1 setPoints:array1];
    [component1 setShouldLabelValues:NO];
    [component1 setColour:PCColorBlue];
    
    [components addObject:component1];
    
    
    
    [component setShouldLabelValues:NO];
    
    //
    [_lineChartView setComponents:components];
    [_lineChartView setXLabels:No_oflabel];

    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	[self.lineChartView setNeedsDisplay];
    return YES;
}

@end

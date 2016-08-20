//
//  WorkOutGuideViewController.m
//  SpotMe
//
//  Created by Muneeba Meer on 25/08/2013.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "WorkOutGuideViewController.h"

@interface WorkOutGuideViewController ()

@end

@implementation WorkOutGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Workout Guide"];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidDisappear:(BOOL)animated{


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

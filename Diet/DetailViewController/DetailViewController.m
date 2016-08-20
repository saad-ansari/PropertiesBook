//
//  DetailViewController.m
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize valuez;
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
    
    

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:valuez ofType:@"html"]isDirectory:NO]]];
    [webView setUserInteractionEnabled:YES];
    [webView setScalesPageToFit:YES];
    
    webView.opaque = NO;
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    
    if ([valuez isEqualToString:@"1"])
        self.title= @"BULKING DIET";
    else if ([valuez isEqualToString:@"2"])
        self.title= @"FAT SHREDDER";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

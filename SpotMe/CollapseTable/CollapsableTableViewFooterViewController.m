//
//  CollapsableTableViewFooterViewController.m
//  CollapsableTableView
//
//  Created by Bernhard Häussermann on 2012/12/15.
//
//

#import "CollapsableTableViewFooterViewController.h"


@implementation CollapsableTableViewFooterViewController

@synthesize titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [titleLabel release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString*) titleText
{
    return titleLabel.text;
}

- (void) setTitleText:(NSString*) titleText
{
    titleLabel.text = titleText;
}

@end

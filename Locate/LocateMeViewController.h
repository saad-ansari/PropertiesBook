//
//  LocateMeViewController.h
//  SpotMeSample
//
//  Created by Muzamil on 7/9/13.
//  Copyright (c) 2013 Muzamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface LocateMeViewController : UIViewController{

    IBOutlet MKMapView *gymsMap;
    NSMutableArray *gymsArray;
    AppDelegate *appDelegate;
    NSMutableArray *pinsArray;

}
- (void)addAnnotationsOnMap;

@end

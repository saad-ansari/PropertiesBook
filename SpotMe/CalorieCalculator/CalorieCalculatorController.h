//
//  CalorieCalculatorController.h
//  SpotMe
//
//  Created by Muneeba Meer on 6/27/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartUIPicker.h"
#import "Database.h"

@interface CalorieCalculatorController : UIViewController{

    SmartUIPicker *smartPicker;
    
    int selectedBtn;
    Database *dbObj;
    NSArray *foodItems;
    int totalCalories;
    IBOutlet UILabel *lblCalories;
    IBOutlet UIView *calorieView;

}
-(IBAction)buttonClicked:(id)sender;
@end

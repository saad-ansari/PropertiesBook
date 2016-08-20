//
//  ImageProgressViewController.h
//  SpotMe
//
//  Created by Ali Naveed on 9/23/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomView.h"
@interface ImageProgressViewController : UIViewController<UINavigationBarDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate , CustomViewDelegate>
{
    AppDelegate *appDelegate;
    NSMutableArray *ImageProgressArray;
    NSMutableDictionary *ForAddImage ;
    NSString *removeImageId;
    
    
    IBOutlet UITableView *tableview;
    int imagesRow;
    int xvalue;
    int ImagesCount;
    int totalImageRow;
    int ImagesAdded;
    int 	myes;
    
    NSMutableArray *imagesObject_arr;

}
@end



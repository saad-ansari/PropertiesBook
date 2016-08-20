//
//  MyGridViewController.h
//  NRGridViewSampleApp
//
//  Created by Louka Desroziers on 04/02/12.
//  Copyright (c) 2012 Novedia Regions. All rights reserved.
//

#import "NRGridViewController.h"
#import "AppDelegate.h"
@interface MyGridViewController : NRGridViewController<UINavigationBarDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
        AppDelegate *appDelegate;
        NSMutableArray *ImageProgressArray;
        NSMutableDictionary *ForAddImage ;
    NSString *removeImageId;

}
@end

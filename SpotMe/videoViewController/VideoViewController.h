//
//  VideoViewController.h
//  SpotMe
//
//  Created by Ali Naveed on 9/27/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BlocksKit/BlocksKit.h>
#import "UIImageView+AFNetworking.h"
#import "CustomView.h"
#import "AppDelegate.h"
#import "JMImageCache.h"
#import "ASIFormDataRequest.h"
@interface VideoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet UIWebView *Webview;
    
    NSMutableArray *myArrayForYouTube;
    IBOutlet UIButton *btn1,*btn2,*btn3;
    
     IBOutlet UIButton *btn4,*btn5,*btn6;
    
    UIView *myBtn1,*myBtn2,*myBtn3;
    
        UIView *Web1,*Web2,*Web3;
    
}
-(UIWebView *)ShowthumbnailView:(NSString *)viewstr;

@end

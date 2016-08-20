//
//  VideoViewController.m
//  SpotMe
//
//  Created by Ali Naveed on 9/27/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "VideoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface VideoViewController ()

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//http://spotme.biz/webservices/public/index.php?controller=web&action=GetUserVideos&sessionid=9147d829f13fcf21fc650f2164f0e0fe&targetid=1&userid=1&start=1&limit=10

- (void)viewDidLoad
{
    [super viewDidLoad];

    myArrayForYouTube = [[NSMutableArray alloc] init];
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetUserVideos&sessionid=%@&targetid=1&userid=%@&start=0&limit=10",[[Singleton getUserData] valueForKey:@"session_id"],[[Singleton getUserData] valueForKey:@"user_id"]];
    
    NSString *urls = [NSString stringWithFormat:@"%@", subPath];
    NSLog(@"get people by gym id==%@",urls);
    
 
    AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getUserVideo:urls];
    [appDelegate.webSer setDelegate:self];

    
    self.navigationItem.title=@"Video";
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];

    
    myBtn1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 90, 90)];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(pickVideo:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn1 addSubview:btn1];
    
    myBtn2 = [[UIView alloc] initWithFrame:CGRectMake(115, 20, 90, 90)];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(pickVideo:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn2 addSubview:btn2];
    
    myBtn3 = [[UIView alloc] initWithFrame:CGRectMake(214, 20, 90, 90)];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(pickVideo:) forControlEvents:UIControlEventTouchUpInside];
    [myBtn3 addSubview:btn3];
    
    
    Web1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 90, 90)];
    Web1.backgroundColor = [UIColor greenColor];
    btn4.tag = 1;
    [btn4 addTarget:self action:@selector(pickVideo:) forControlEvents:UIControlEventTouchUpInside];
    [Web1 addSubview:btn4];

    Web2 = [[UIView alloc] initWithFrame:CGRectMake(115, 20, 90, 90)];
    Web2.backgroundColor = [UIColor greenColor];
    btn5.tag = 2;
    [btn1 addTarget:self action:@selector(pickVideo:) forControlEvents:UIControlEventTouchUpInside];
    [Web2 addSubview:btn5];

    Web3 = [[UIView alloc] initWithFrame:CGRectMake(214, 20, 90, 90)];
    Web3.backgroundColor = [UIColor greenColor];
    btn6.tag = 3;
    [btn6 addTarget:self action:@selector(pickVideo:) forControlEvents:UIControlEventTouchUpInside];
    [Web3 addSubview:btn6];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)pickVideo:(id)sender
{

    if ([sender tag]>3) {
        
        if ([myArrayForYouTube count] >0) {
            
            if ([myArrayForYouTube count] == 1)
            {
                [self.view addSubview:Web2];
            }
            
            if ([myArrayForYouTube count] == 2)
            {
                [self.view addSubview:Web3];
            }
        }
        
    }
    else{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];


//    NSArray *mediaTypesAllowed = [NSArray arrayWithObject:@"public.movie"];
//    [imagePicker setMediaTypes:mediaTypesAllowed];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
//    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
//    if([mediaType isEqualToString:@"public.movie"]){
//    }
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //NSLog(@"type=%@",type);
    if ([type isEqualToString:(NSString *)kUTTypeVideo] ||
        [type isEqualToString:(NSString *)kUTTypeMovie])
    {// movie != video
        NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"myVideo %@",[NSString stringWithFormat:@"%@", urlvideo]);
        NSData *webData = [NSData dataWithContentsOfURL:urlvideo];

        [self post:webData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    
}

#pragma mark-WebService Delegates
-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        NSLog(@"dicationary %@",[objectsDict valueForKeyPath:@"Result"]);
        myArrayForYouTube = [objectsDict valueForKeyPath:@"Result"];
     
        [self forCheckButtonShow];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[objectsDict valueForKey:@"Message"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        
        [alertView show];
    }
    
}
-(void)webServiceRequestFailed:(ASIHTTPRequest *)request{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)forCheckButtonShow
{
    
    if ([myArrayForYouTube count] >0) {
        [self youTubeVideo:[[myArrayForYouTube objectAtIndex:0] valueForKey:@"video_url"]];
        
        if ([myArrayForYouTube count] == 1)
        {
            [self.view addSubview:Web1];
            
            [Web1 addSubview:[self ShowthumbnailView:[[myArrayForYouTube objectAtIndex:0] valueForKey:@"video_url"]]];
            
            [self.view addSubview:myBtn2];
        }

        if ([myArrayForYouTube count] == 2)
        {
            [self.view addSubview:Web1];
            [Web1 addSubview:[self ShowthumbnailView:[[myArrayForYouTube objectAtIndex:0] valueForKey:@"video_url"]]];

            [self.view addSubview:Web2];
            [Web2 addSubview:[self ShowthumbnailView:[[myArrayForYouTube objectAtIndex:1] valueForKey:@"video_url"]]];

            [self.view addSubview:myBtn3];
        }
        
        if ([myArrayForYouTube count] == 3)
        {
            [self.view addSubview:Web1];
            [Web1 addSubview:[self ShowthumbnailView:[[myArrayForYouTube objectAtIndex:0] valueForKey:@"video_url"]]];
            
            [self.view addSubview:Web2];
            [Web2 addSubview:[self ShowthumbnailView:[[myArrayForYouTube objectAtIndex:1] valueForKey:@"video_url"]]];
            
            [self.view addSubview:Web3];
            [Web3 addSubview:[self ShowthumbnailView:[[myArrayForYouTube objectAtIndex:2] valueForKey:@"video_url"]]];

        }

    }
    else
    {
        [self.view addSubview:myBtn1];
        
        btn2.hidden = YES;
        btn3.hidden = YES;
        Webview.hidden = YES;
    }
}

- (void)post:(NSData *)webData
{
    NSString *ws = [NSString stringWithFormat:@"%@controller=web&action=UploadVideo", SERVER_URL];
    
    NSURL *url = [NSURL URLWithString:ws];
    
     NSData *postData = [[NSData alloc] initWithData:webData] ;
     ASIFormDataRequest *request;
     request = [[ASIFormDataRequest alloc] initWithURL:url] ;
     
     [request setPostValue:[[Singleton getUserData] valueForKey:@"user_id"] forKey:@"userid"];
     [request setPostValue:[[Singleton getUserData] valueForKey:@"session_id"] forKey:@"sessionid"];
     [request setPostValue:@"iphone" forKey:@"device"];
     
     [request setData:postData withFileName:@"myPhoto.MOV"
     andContentType:@"MOV" forKey:@"file"];
     
     [request setRequestMethod:@"POST"];
     [request setShouldAttemptPersistentConnection:YES];
     //    [request setUploadProgressDelegate:progressView];
     [request setCompletionBlock:^{
     NSLog(@"success with response string %@", request.responseString);

     
     }];
     
     [request setFailedBlock:^{
     NSLog(@"error: %@", request.error.localizedDescription);
     }];
     
     [request startAsynchronous];
 
}

-(void)youTubeVideo:(NSString *)myStr
{
    // Do any additional setup after loading the view from its nib.
    float width = 280.0f;
    float height = 194.0f;
    NSString *youTubeURL = myStr;
    Webview.frame = CGRectMake(20, 141, width, height);
    NSMutableString *html = [[NSMutableString alloc] initWithCapacity:1] ;
    [html appendString:@"<html><head>"];
    [html appendString:@"<style type=\"text/css\">"];
    [html appendString:@"body {"];
    [html appendString:@"background-color: transparent;"];
    [html appendString:@"color: white;"];
    [html appendString:@"}"];
    [html appendString:@"</style>"];
    [html appendString:@"</head><body style=\"margin:0\">"];
    [html appendFormat:@"<embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\"", youTubeURL];
    [html appendFormat:@"width=\"%0.0f\" height=\"%0.0f\"></embed>", width, height];
    [html appendString:@"</body></html>"];
    
    [Webview loadHTMLString:html baseURL:nil];

}

-(UIWebView *)ShowthumbnailView:(NSString *)viewstr
{
    UIWebView *testView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    NSString *youTubeURL = viewstr;

    NSMutableString *html = [[NSMutableString alloc] initWithCapacity:1] ;
    [html appendString:@"<html><head>"];
    [html appendString:@"<style type=\"text/css\">"];
    [html appendString:@"body {"];
    [html appendString:@"background-color: transparent;"];
    [html appendString:@"color: white;"];
    [html appendString:@"}"];
    [html appendString:@"</style>"];
    [html appendString:@"</head><body style=\"margin:0\">"];
    [html appendFormat:@"<embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\"", youTubeURL];
    [html appendFormat:@"width=\"90.0f\" height=\"90.0f\"></embed>"];
    [html appendString:@"</body></html>"];
    
    [testView loadHTMLString:html baseURL:nil];
    
    return testView;
    
}

@end

//
//  ImageProgressViewController.m
//  SpotMe
//
//  Created by Ali Naveed on 9/23/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "ImageProgressViewController.h"
#import <BlocksKit/BlocksKit.h>
#import "UIImageView+AFNetworking.h"
#import "CustomView.h"
#import "JMImageCache.h"
@interface ImageProgressViewController ()

@end

@implementation ImageProgressViewController

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
    // Do any additional setup after loading the view from its nib.
    
 
   
    ImageProgressArray = [[NSMutableArray alloc] init];
    [[JMImageCache sharedCache] removeAllObjects];
    ForAddImage = [[NSMutableDictionary alloc] init];
    ForAddImage = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"22",@"id",@"22",@"user_id",@"22",@"picture_url",@"22",@"device",@"22",@"is_deleted",@"22",@"date_added",nil];
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self getData];
    [ImageProgressArray addObject:ForAddImage];

   
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title=@"Image Progress";
    [self.navigationController.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - Tableview delegate and datasource -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"cell %f",ceil(ImagesCount/3.0));
    int value2 = 0;
	int array22 = [ImageProgressArray count];
    
	if (array22 % 3 == 0) {
		value2 = array22/3 ;
	}
    else
        if(array22 % 3 == 1 || array22 % 3 == 2 ){
		value2 = array22/3;
		value2 = value2+1;
	}
        return value2;
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell-%d-%d",indexPath.row,indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   // if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        int i =0;
        if (indexPath.row == 0 )
            i = indexPath.row;
        else
            i = indexPath.row * 3;
        
            int checkingnumber =0;
        xvalue = 0;
        for (int loop =0 ; loop<3 && loop<[ImageProgressArray count]; loop++)
        {
            NSLog(@"cell mine out ");
            
            if (i<[ImageProgressArray count]) {
                

                NSString *imageString = [[[ImageProgressArray objectAtIndex:i]
                                          valueForKey:@"picture_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

                if ([imageString isEqualToString:@"22"]) {
                    
                    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(xvalue, 0, 95, 120)];
                    [myView setBackgroundColor:[UIColor clearColor]];
                    
                    UIButton *mybtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    mybtn.frame = CGRectMake(0, 0, 94, 93);
                    [mybtn  setBackgroundImage:[UIImage imageNamed:@"add_imagebox.png"] forState:UIControlStateNormal];
                    [mybtn addTarget:self action:@selector(showImageTakeList) forControlEvents:UIControlEventTouchUpInside];
                    [myView addSubview:mybtn];
                    
                    [cell addSubview:myView];
                }
                else
                {
                CustomView *imgthumbnail = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil] objectAtIndex:0];
                imgthumbnail.frame = CGRectMake(xvalue, 0, imgthumbnail.frame.size.width, imgthumbnail.frame.size.height);
                
                imgthumbnail.commentPostBtn.tag = myes;
                imgthumbnail.datelbl.text = [[ImageProgressArray objectAtIndex:i]
                                                  valueForKey:@"date_added"];
                    
//                [imgthumbnail.commentPostBtn addTarget:self action:@selector(DeleteImageWithID:) forControlEvents:UIControlEventTouchUpInside];
                    imgthumbnail.mydict = [[ImageProgressArray objectAtIndex:i] copy];
                    imgthumbnail.delegate = self;
                NSLog(@"cell mine inside %@",imageString);
                    
                [imgthumbnail.commentPostField setImageWithURL:[NSURL URLWithString:imageString]];
                
                
                [cell addSubview:imgthumbnail];
                }
                
                i++;
                checkingnumber = checkingnumber+1;
                myes += 1;
                xvalue = xvalue+100;
            }
            
        }
    }
        return cell;
    
}
-(void)buttonIdwithString:(NSDictionary *)mystr;
{
    NSString *imageString = [mystr valueForKey:@"id"];
    [self DeleteImageWithID:imageString];
    

}
 /*
        
        while (totalImageRow < ImagesCount)
        {
            
            //Thumbnail Image
            
            CustomView *imgthumbnail = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil] objectAtIndex:0];
            imgthumbnail.frame = CGRectMake(xvalue, 0, imgthumbnail.frame.size.width, imgthumbnail.frame.size.height);
            
            NSString *imageString = [[[ImageProgressArray objectAtIndex:indexPath.row]
                                      valueForKey:@"picture_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [imgthumbnail.commentPostField setImageWithURL:[NSURL URLWithString:imageString]];
            

            [cell addSubview:imgthumbnail];
           
           
            ImagesAdded++;
            
            
            xvalue = xvalue+100;
            totalImageRow++;
            if(totalImageRow %3 ==0)
            {
                xvalue=0;
                // totalImageRow=0;
                break;
            }
        }
        
    }
    return cell;
}*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)ThumbnailTap:(UIButton *)sender
{
    NSLog(@"image tag %d",sender.tag);
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Succes" message:@"I am tapped" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData {

    xvalue =0;
    ImagesCount =10;
    totalImageRow =0;
    myes = 1;

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer getImageProgress];
    [appDelegate.webSer setDelegate:self];
    
}
-(void)DeleteImageWithID:(NSString *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *imageString = sender;
                             
    
    [appDelegate.webSer DeleteImage:imageString];
    removeImageId = [NSString stringWithFormat:@"%@",sender];
    
    [appDelegate.webSer setDelegate:self];
    
}

-(void)webServiceRequestFinished:(NSString *)responseStr {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        if(![[objectsDict valueForKey:@"Result"] isKindOfClass:[NSArray class]])
        {
            NSLog(@"%d",[ImageProgressArray count]);
            /*    for (int index =0;index <[ImageProgressArray count]; index++)
             {
             //replace condition with an expression that returns YES
             //for objects that should be deleted.
             
             NSLog(@"%@ == %@",[[ImageProgressArray objectAtIndex:index]
             valueForKey:@"id"],removeImageId);
             
             //                if ([[[ImageProgressArray objectAtIndex:index]
             //                      valueForKey:@"id"] isEqualToString:removeImageId])
             //                    [ImageProgressArray removeObjectAtIndex: index];
             
             }*/
            [self getData];
        }
        else
        {
            if([ImageProgressArray count]>0)
                [ImageProgressArray removeAllObjects];
            
        
            ImageProgressArray  = [[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
            [ImageProgressArray addObject:ForAddImage];
            
                NSLog(@"my Count %d",[ImageProgressArray count]);
          
        }
        
        xvalue =0;
        ImagesCount =10;
        totalImageRow =0;

        [tableview reloadData];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[objectsDict valueForKey:@"Message"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OKay"
                                                  otherButtonTitles:nil];
        
        
        [alertView show];
    }
    
}
-(void)webServiceRequestFailed:(ASIHTTPRequest *)request {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}




//----------Image upload
#pragma mark -
#pragma mark void
// Upload LIst - upload image via photogallery or camera
- (void) showImageTakeList
{
	UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"Select Image Via"]
													  delegate:self
											 cancelButtonTitle:@"Cancel"
										destructiveButtonTitle:nil
											 otherButtonTitles:@"Photo Gallery",@"Take Photo",nil];
	
	menu.tag = 1;
	[menu showInView:self.view];
	[menu setBounds:CGRectMake(0,0,320, 230) ];

}
#pragma mark -
#pragma mark  UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if([actionSheet tag] == 1)
	{
		if(buttonIndex == 0)
		{
			[self GoToImageGallery];
		}
		if(buttonIndex == 1)
		{
			[self GoToTakeAPhoto];
		}
	}
}
-(void) GoToImageGallery
{
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //		picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];

	}
	else
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error accessing Photo Library" message:@"This device does not support a Photo Library." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
    
	}
}
-(void)GoToTakeAPhoto
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //		picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];

	}
	else {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error accessing Camera" message:@"This device is unable to access camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
	}
}
//ragma mark -
#pragma mark UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
	Singleton *_singleton = [Singleton retriveSingleton];
	
	[picker dismissModalViewControllerAnimated:YES];
	UIImage *myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	CGSize newSize = CGSizeMake(320, 480);
	UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
	[myImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
	myImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	NSData *webData = UIImageJPEGRepresentation(myImage, 1);
    
    NSString *ws = [NSString stringWithFormat:@"%@controller=web&action=UploadPictureInAlbum", SERVER_URL];
    
    NSURL *url = [NSURL URLWithString:ws];
    NSData *postData = [[NSData alloc] initWithData:webData] ;
    ASIFormDataRequest *request;
    request = [[ASIFormDataRequest alloc] initWithURL:url] ;
    
    [request setPostValue:[[Singleton getUserData] valueForKey:@"user_id"] forKey:@"userid"];
    [request setPostValue:[[Singleton getUserData] valueForKey:@"session_id"] forKey:@"sessionid"];
    [request setPostValue:@"iphone" forKey:@"device"];
    
    [request setData:postData withFileName:@"myPhoto.jpg"
      andContentType:@"image/jpeg" forKey:@"file"];
    
    [request setRequestMethod:@"POST"];
    [request setShouldAttemptPersistentConnection:YES];
    //    [request setUploadProgressDelegate:progressView];
    [request setCompletionBlock:^{
        NSLog(@"success with response string %@", request.responseString);
        [self getData];
        
    }];
    
    [request setFailedBlock:^{
        NSLog(@"error: %@", request.error.localizedDescription);
    }];
    
    [request startAsynchronous];
	// Save to CreateInvitationDictionary this image
    //	NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_singleton.CreateInvitationDetails];
    //	[dic setObject:webData forKey:@"image"];
    //	_singleton.CreateInvitationDetails = dic;
	
}



@end

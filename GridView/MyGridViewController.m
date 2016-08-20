//
//  MyGridViewController.m
//  NRGridViewSampleApp
//
//  Created by Louka Desroziers on 04/02/12.
//  Copyright (c) 2012 Novedia Regions. All rights reserved.
//

#import "MyGridViewController.h"
#import "AppDelegate.h"
#import "JMImageCache.h"


static BOOL const _kNRGridViewSampleCrazyScrollEnabled = NO; // For the lulz.
@implementation MyGridViewController
{
    BOOL _firstSectionReloaded; // For reloading sections/cells demo
}

#pragma mark - Crazy Scroll LULZ

- (void)__beginGeneratingCrazyScrolls
{
    if(_kNRGridViewSampleCrazyScrollEnabled==NO)return;
    
    NSInteger randomSection = arc4random() % ([[[self gridView] dataSource] respondsToSelector:@selector(numberOfSectionsInGridView:)]
                                              ? [[[self gridView] dataSource] numberOfSectionsInGridView:[self gridView]]
                                              : 1);
    NSInteger randomItemIndex = arc4random() % [[[self gridView] dataSource] gridView:[self gridView] 
                                                               numberOfItemsInSection:randomSection];
    
    
    [[self gridView] selectCellAtIndexPath:[NSIndexPath indexPathForItemIndex:randomItemIndex inSection:randomSection]
                                autoScroll:YES 
                            scrollPosition:NRGridViewScrollPositionAtMiddle
                                  animated:YES];
    
    [self performSelector:@selector(__beginGeneratingCrazyScrolls) 
               withObject:nil 
               afterDelay:2.5 
                  inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}

- (void)__endGeneratingCrazyScrolls
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self 
                                             selector:@selector(__beginGeneratingCrazyScrolls) 
                                               object:nil];
}

- (void)__reloadFirstSection:(id)sender
{
    _firstSectionReloaded = !_firstSectionReloaded;
    [[self gridView] reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withCellAnimation:NRGridViewCellAnimationLeft];
}

- (void)__reloadFirstSection1
{
    _firstSectionReloaded = !_firstSectionReloaded;
    [[self gridView] reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withCellAnimation:NRGridViewCellAnimationLeft];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    [[self gridView]setBackgroundColor:[UIColor clearColor]];

}

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle
- (BOOL)canBecomeFirstResponder{return YES;}

- (void)loadView
{ 
    [super loadView];
    [[self gridView] setCellSize:CGSizeMake(90, 106)];
    NSLog(@"size of tab is %@",NSStringFromCGRect([self gridView].frame));
}


-(void)getData
{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [appDelegate.webSer getImageProgress];
        [appDelegate.webSer setDelegate:self];
    
}
-(void)DeleteImageWithID:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate.webSer DeleteImage:[NSString stringWithFormat:@"%d",[sender tag]-1]];
    removeImageId = [[NSString stringWithFormat:@"%d",[sender tag]-1] copy];
    
    [appDelegate.webSer setDelegate:self];

}

-(void)webServiceRequestFinished:(NSString *)responseStr ;{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [responseStr JSONValue];
    
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
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(__reloadFirstSection1) userInfo:nil repeats:NO];
        }
        else
        {
        if([ImageProgressArray count]>0)
        [ImageProgressArray removeAllObjects];
        
        ImageProgressArray  = [[NSMutableArray alloc] initWithArray:[objectsDict valueForKey:@"Result"]];
        [ImageProgressArray addObject:ForAddImage];
            [self __reloadFirstSection1];
        }
        
            

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
-(void)webServiceRequestFailed:(ASIHTTPRequest *)request{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     ImageProgressArray = [[NSMutableArray alloc] init];
    [[JMImageCache sharedCache] removeAllObjects];
    ForAddImage = [[NSMutableDictionary alloc] init];
    ForAddImage = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"22",@"id",@"22",@"user_id",@"22",@"picture_url",@"22",@"device",@"22",@"is_deleted",@"22",@"date_added",nil];
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self getData];
    [ImageProgressArray addObject:ForAddImage];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark - NRGridView Data Source



- (NSInteger)numberOfSectionsInGridView:(NRGridView *)gridView
{
    return 1;
}

- (NSInteger)gridView:(NRGridView *)gridView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%d",[ImageProgressArray count]);
    
    return [ImageProgressArray count];
}

- (NSString*)gridView:(NRGridView *)gridView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSString*)gridView:(NRGridView *)gridView titleForFooterInSection:(NSInteger)section
{
    return nil;
}  

- (CGRect)rectForHeaderInSection:(NSInteger)section
{
    return CGRectMake(0, 0, 0, 0);
}

- (NRGridViewCell*)gridView:(NRGridView *)gridView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyCellIdentifier = @"MyCellIdentifier";
    
    NRGridViewCell* cell = [gridView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    
    //if(cell == nil)
    {
        cell = [[[NRGridViewCell alloc] initWithReuseIdentifier:MyCellIdentifier] autorelease];
        
        [[cell textLabel] setFont:[UIFont boldSystemFontOfSize:11.]];
        [[cell detailedTextLabel] setFont:[UIFont systemFontOfSize:11.]];

    }
    
    if (indexPath.row == [ImageProgressArray count]-1) {
        
        UIButton *mybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mybtn setImage:[UIImage imageNamed:@"add_imagebox.png"] forState:UIControlStateNormal];
        mybtn.frame = CGRectMake(2, 2, 96, 96);
        [mybtn addTarget:self action:@selector(showImageTakeList) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:mybtn];


        
    }
    else{
//        cell.imageView.image = (indexPath.section == 0 && _firstSectionReloaded ? nil : [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", (indexPath.row%7)]]);
        
        NSString *imageString = [[[ImageProgressArray objectAtIndex:indexPath.row]
                                 valueForKey:@"picture_url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.imageView setImageWithURL:[NSURL URLWithString:imageString]];
        [cell.imageView setBackgroundColor:[UIColor greenColor]];
         
        UIButton *mybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mybtn setImage:[UIImage imageNamed:@"delete_box.png"] forState:UIControlStateNormal];
        mybtn.frame = CGRectMake(0, 80, 94, 32);
        mybtn.tag = [[[ImageProgressArray objectAtIndex:indexPath.row]
                      valueForKey:@"id"] intValue]+1;
        [mybtn addTarget:self action:@selector(DeleteImageWithID:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:mybtn];
        
    }
//    NSLog(@"%@",[[ImageProgressArray objectAtIndex:indexPath.row] valueForKey:@"picture_url"]);
    return cell;
}
-(void)mybtn:(id)sender
{
    NSLog(@"%d",[sender tag]);
}
#pragma mark - NRGridView Delegate

- (void)gridView:(NRGridView *)gridView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)gridView:(NRGridView *)gridView didLongPressCellAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [super dealloc];
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
	[menu release];
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
        [picker release];
	}
	else
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error accessing Photo Library" message:@"This device does not support a Photo Library." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
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
        [picker release];
	}
	else {
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error accessing Camera" message:@"This device is unable to access camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}
#pragma mark -
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
    request = [[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
    
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

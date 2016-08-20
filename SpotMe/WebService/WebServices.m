//
//  WebServices.h
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import "WebServices.h"

//#import "AppDelegate.h"
#import "ASIHTTPRequest.h"

@implementation WebServices

@synthesize delegate ;
@synthesize access_token ;


-(id)initWithAccessToken:(NSString *)accessToken ;{
    self = [super init];
        self.access_token = accessToken ;
    return self ;
}


-(void)getLogin:(NSString *)fullData ;{
    
   // appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, fullData];
    NSLog(@"ddffd   %@",urls);
    urls = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}


-(void)getSignUp:(NSString *)fullData ;{
    
    // appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, fullData];
    NSLog(@"ddffd==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
-(void)getPeopleByDistance:(NSString*)distance_{

    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetUsersByDistance&userid=%@&sessionid=%@&latitude=%@&longitude=%@&start=0&limit=10&distance=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"],[[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"],distance_];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];


}
-(void)addBroadCastMsg:(NSString*)msgText{


    //http://appxone.com/Testing/SpotMe/public/index.php?controller=web&action=AddBroadcast&userid=1&sessionid=81da15326037fb564d48adf72228c8f0&message=Thisismessage.Didyougetthis&device=iphone
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=AddBroadcast&userid=%@&sessionid=%@&message=%@&device=iphone",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],msgText];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    
    NSLog(@"get add broadcaste==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
     [request addRequestHeader:@"callType" value:@"addBroadCast"];
    [request setDelegate:self];
    [request startAsynchronous];


}
-(void)getBroadCastMessages{

//http://appxone.com/Testing/SpotMe/public/index.php?controller=web&action=GetBroadcast&userid=1&sessionid=asljfaoer9809f09sn8ae7fsd8f09asm80f

    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetBroadcast&userid=%@&sessionid=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"]];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)getImageProgress{
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetAlbumPicture&userid=%@&sessionid=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"]];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
-(void)DeleteImage:(NSString*)receiverId
{
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=DeleteAlbumPicture&userid=%@&sessionid=%@&picture_id=%@&device=iphone",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],receiverId];

    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}


// http://www.spotme.biz/webservices/public/index.php?controller=web&action=GetAllWorkoutParameters
-(void)sendMsgToUser:(NSString*)receiverId andMsg:(NSString*)msgText{
    
   // http://localhost/SpotMe/public/index.php?controller=web&action=SendMessage&userid=6&sessionid=ebdc4a3005c3bc3606918d023bcfae55&to=7&text=I would like to join you for workout today.&device=iphone
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=SendMessage&userid=%@&sessionid=%@&to=%@&text=%@&device=iphone"
                       ,[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],receiverId,msgText];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
}
-(void)deleteMessage:(NSString*)msgId{

    //http://appxone.com/Testing/SpotMe/public/index.php?controller=web&action=DeleteMessage&userid=1&sessionid=a039d902ad1b2633126b56d7ee93e8ac&id=69&device=iphone
    
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=DeleteMessage&userid=%@&sessionid=%@&id=%@&device=iphone"
                       ,[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],msgId];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

}
-(void)blockUser:(NSString*)userId{

    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=BlockUser&userid=%@&sessionid=%@&blockeduser=%@&device=iphone"
,[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],userId];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];


}
-(void)getAllNearByGyms{
  
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetAllGymLocations&parentid=%@&latitude=%@&longitude=%@&limit=10&distance=30",[[Singleton getUserData] valueForKey:@"gym_id"],[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"],[[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"]];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people distance==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}


-(NSString *)DatewithFormat:(NSDate*)date_
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
   // NSDate *now = [NSDate date];
    
    NSString *theDate = [dateFormat stringFromDate:date_];
    
    
    return theDate;
}
-(void)getServerTime{


    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetServerTime"];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"seerver time==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"callType" value:@"serverTime"];
    [request setDelegate:self];
    [request startAsynchronous];


}
-(void)updateProfile:(NSString*)updateValues{
    
    
    //http://localhost/SpotMe/public/index.php?controller=web&action=SetWorkout&userid=6&sessionid=ebdc4a3005c3bc3606918d023bcfae55&workout=1-2-3%7C4-5-6%7C8-9-10%7C1-0-0&dateadded=2013-05-31
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=SetWorkout&userid=%@&sessionid=%@&workout=%@&date_workout=%@&device=iphone",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],
                       updateValues,[NSString stringWithFormat:@"%@",[self DatewithFormat:[NSDate date]]]];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"set workout==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
}
/*-(void)updateProfile:(NSString*)updateValues{

    
    //http://localhost/SpotMe/public/index.php?controller=web&action=SetWorkout&userid=6&sessionid=ebdc4a3005c3bc3606918d023bcfae55&workout=1-2-3%7C4-5-6%7C8-9-10%7C1-0-0&dateadded=2013-05-31
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=SetWorkout&userid=%@&sessionid=%@&workout=%@&date_workout=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],
                       updateValues,[NSString stringWithFormat:@"%@",[NSDate date]]];
  
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"set workout==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

    

}*/
-(void)getUsersByGymId:(NSString*)gymId{
    //http://appxone.com/Testing/SpotMe_beta/public/index.php?controller=web&action=GetUsersByGymId&userid=73&sessionid=b91790ea59ea62b8505396ea4769db6b&gymid=2&start=10&limit=10
    
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetUsersByGymId&userid=%@&sessionid=%@&gymid=%@&start=0&limit=10",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],[[Singleton getUserData] valueForKey:@"gym_id"]];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get people by gym id==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];


}

-(void)getAllMessages:(NSString*)msgType{
//http://appxone.com/Testing/SpotMe_beta/public/index.php?controller=web&action=GetMessage&userid=1&sessionid=e4d9b46d765c2bf0fb01b5159f6fa59f&type=sent
    

    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetMessage&userid=%@&sessionid=%@&type=%@&start=0&limit=10",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],msgType];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get message==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

}
-(void)getUserProfile:(NSString*)userId{
//    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString:[NSString stringWithFormat:@"http://appxone.com/Testing/SpotMe_beta/public/index.php?controller=web&action=UserProfile&userid=1&sessionid=ca49bd2151652f6e8475e510ac4021c8&targetid=72"]]];

    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=UserProfile&userid=%@&sessionid=%@&targetid=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],userId];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get profile==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

    

}
-(void)getWorkoutByDate:(NSDate*)date_ andUserId:(NSString*)userId{
   //http://appxone.com/Testing/SpotMe_beta/public/index.php?controller=web&action=GetWorkoutByDate&userid=1&sessionid=1aac9a41ce85358bc1ecedfd1fe7d416&targetid=1&date=2013-06-17
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetWorkoutByDate&userid=%@&sessionid=%@&targetid=%@&date=%@",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],userId,[self DatewithFormat:date_]];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get profile==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
}
-(void)updateWorkout:(NSString*)updateValues date:(NSDate*)date_{

    //http://localhost/SpotMe/public/index.php?controller=web&action=UpdateWorkout&userid=1&sessionid=e386d942463a8d3cba17c31dc2bb864b&data=1-1-10-10|2-2-10-10|3-3-10-10|4-4-10-10&date_workout=2
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=UpdateWorkout&userid=%@&sessionid=%@&data=%@&date_workout=%@&device=iphone",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],
                       updateValues,[NSString stringWithFormat:@"%@",[self DatewithFormat:date_]]];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"update workout==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];


}
-(void)updateUserLocation{


    NSString *paramStr=[NSString stringWithFormat:@"controller=web&action=UpdateUserLocation&userid=%@&sessionid=%@&latitude=%@&longitude=%@", [[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"],[[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"],[[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"]
];
    
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, paramStr];
    NSLog(@"update url==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

    NSLog(@"paramt start %@",paramStr);
   
}
///=====

-(void)getHeadLine{
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetAnimatedText&userid=%@&sessionid=%@&device=iphone",[[Singleton getUserData] valueForKey:@"user_id"],[[Singleton getUserData] valueForKey:@"session_id"]];
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get profile==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
}


/////-------======
- (void) requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"Webservice request started...");
}

-(void)parseServerTimeData:(NSString*)response{

    NSString *responseStr=nil;
    responseStr = [response stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    
    NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
    NSLog(@"Status %@",[objectsDict valueForKey:@"Status"]);
    
    NSString *status = [NSString stringWithFormat:@"%@",[objectsDict valueForKey:@"Status"]];
    
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"true"]) {
        
        NSLog(@"data tmem %@",[responseDict1 valueForKeyPath:@"Data.Result"]);
        
        [Singleton  saveSerTime:[NSString stringWithFormat:@"%@",[responseDict1 valueForKeyPath:@"Data.Result"]]];
              
    }


}
#pragma -
#pragma ASIHTTPDelegate Request
- (void)requestFinished:(ASIHTTPRequest *)request {
  //  NSLog(@"Request Finished") ;
    NSString *responseStr = [request responseString] ;
    NSLog(@"Response : %@", [responseStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    
    NSLog(@"--header %@",request.requestHeaders);
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"<pre>" withString:@""];
    responseStr = [responseStr stringByReplacingOccurrencesOfString:@"</pre>" withString:@""];
    
    if([[request.requestHeaders valueForKey:@"callType"] isEqualToString:@"serverTime"])
    {
    
        [self parseServerTimeData:responseStr];
    
    }
    else{
    if([delegate respondsToSelector:@selector(webServiceRequestFinished:)]){
        [delegate webServiceRequestFinished:responseStr];
    }
    
    if([delegate respondsToSelector:@selector(webServiceRequestFinished:andResponseStr:)]){
        [delegate webServiceRequestFinished:request andResponseStr:responseStr];
    }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    
    
    if([delegate respondsToSelector:@selector(webServiceRequestFailed:)]){
        [delegate webServiceRequestFailed:request ];
    }
    NSLog(@"Request Failed");
    NSLog(@"Request Failed Error : %@", [request.error description]) ;
}


- (void)functionValues:(NSString *)fullData
{
    
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, fullData];
    NSLog(@"ddffd==%@",urls);


    
    NSURL *url = [NSURL URLWithString:urls];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        responseString = [responseString stringByReplacingOccurrencesOfString:@"<pre>" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"</pre>" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];

//        NSLog(@" ===%@", responseString) ;
        
        
        NSDictionary *responseDict1 = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

        NSDictionary *objectsDict =[responseDict1 objectForKey:@"Data"];
        
        NSMutableArray *Result = [objectsDict valueForKey:@"Result"];
        NSLog(@"Status %@",[Result objectAtIndex:0]);

        if([delegate respondsToSelector:@selector(webServiceinSameFunction:)]){
            [delegate webServiceinSameFunction:Result];
        }
   
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@" ===  %@", error) ;
        
    }];
    [request startAsynchronous];
}

-(void)GetAllWorkoutParameters{
    
    //        http://www.spotme.biz/webservices/public/index.php?controller=web&action=GetAllWorkoutParameters
    
    NSString *subPath=[NSString stringWithFormat:@"controller=web&action=GetAllWorkoutParameters"];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"seerver time==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}

-(void)getUserVideo:(NSString*)urlStrValue{
    
    NSString *subPath=[NSString stringWithFormat:@"%@",urlStrValue];
    
    NSString *urls = [NSString stringWithFormat:@"%@%@", SERVER_URL, subPath];
    NSLog(@"get profile==%@",urls);
    NSURL *url = [NSURL URLWithString:urls];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
}

@end

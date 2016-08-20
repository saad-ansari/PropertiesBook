//
//  Singleton.m
//  WhoHasIHave
//
//  Created by ALI NAVEED on 1/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"
#import "Reachability.h"

@implementation Singleton
@synthesize checkLogIn,userDetail,ItemsDetail,addphotosDetails,Object,itemIdValue,ItemsPhotosDetail,WhoHas_matches,tradeoffer_itemdetail;
///WhoHas
@synthesize WhoHas_itemDetails,tradeoffer_CountMsg_Past,tradeoffer_CountMsg,checkservices,checkupdate;
//Search
@synthesize Search_ihave_type,TrackerView;
@synthesize Search_whohas_type,messagedelete,UpdateIhaveItems,tabBar,TradeCompleteBool;

static Singleton *sharedSingleton = nil;

+(Singleton *)retriveSingleton
{
	@synchronized(self)
	{
		if(sharedSingleton ==nil)
		{
			sharedSingleton =[[Singleton alloc]init];
		}
	}
	return sharedSingleton;
}

+(id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if(sharedSingleton ==nil)
		{
			sharedSingleton = [super allocWithZone:zone];
			return sharedSingleton;
		}
	}
	return nil;
	
}
+(BOOL)connectToInternet
{
    Reachability *r = [Reachability reachabilityWithHostname:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];    
    BOOL result = NO;
    if (internetStatus == ReachableViaWiFi )
    {
        result = YES;    
    } 
    else if(internetStatus == ReachableViaWWAN){
        result = YES;
    }
    return result;
}

+ (BOOL)validateEmail:(NSString *)email {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}

+ (void)AlertViewsFunction:(NSString *)alertViews
{
UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:alertViews delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
[alert show];
}
+(void)saveUserData:(NSMutableDictionary*)dict{


    if(dict){
    [dict removeObjectForKey:@"profile_pic_url"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict  forKey:@"userInfor"];

                  
    }


}
+(void)saveSerTime:(NSString*)time_{


    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy hh:mm:ss"];
    NSDate *serverDate=[dateFormat dateFromString:time_];
    NSLog(@"server dat4 %@",serverDate);
    NSDate *now = [NSDate date];
    
    NSTimeInterval difference=[now timeIntervalSinceDate:serverDate];
    NSLog(@"differnce %f",difference);
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",difference] forKey:@"difference"];
    

    NSLog(@"----timmee %@",[self getServerTime]);
}
+(NSString*)getServerTime{

  return   [[NSUserDefaults standardUserDefaults]  valueForKey:@"difference"];

}
+(NSDictionary*)getUserData{

    
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"userInfor"];

}

@end

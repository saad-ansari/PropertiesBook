//
//  WebServices.h
//  SpotMe
//
//  Created by AliNaveed on 6/19/13.
//  Copyright (c) 2013 Sample. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"

//@class AppDelegate;

@protocol WebServicesDelegate <NSObject>

-(void)webServiceRequestFinished:(NSString *)responseStr ;
-(void)webServiceRequestFinished:(ASIHTTPRequest *)request andResponseStr:(NSString *)responseStr ;
-(void)webServiceinSameFunction:(NSMutableArray *)responseStr ;
-(void)webServiceRequestFailed:(ASIHTTPRequest *)request;
@end

@interface WebServices : NSObject<ASIHTTPRequestDelegate> {
    
    //AppDelegate *appDelegate ;
}
@property(nonatomic, retain) NSString *access_token ;

@property(nonatomic, retain) id delegate ;
-(void)getSignUp:(NSString *)fullData;
-(void)getLogin:(NSString *)fullData;
- (void)functionValues:(NSString *)fullData;
-(void)updateUserLocation;
-(void)getPeopleByDistance:(NSString*)distance_;
-(void)getAllNearByGyms;
-(void)getAllMessages:(NSString*)msgType;
-(void)getUsersByGymId:(NSString*)gymId;
-(void)getUserProfile:(NSString*)userId;
-(void)updateProfile:(NSString*)updateValues;
-(void)getServerTime;
-(void)getBroadCastMessages;
-(void)addBroadCastMsg:(NSString*)msgText;
-(void)blockUser:(NSString*)userId;
-(void)deleteMessage:(NSString*)msgId;
-(void)sendMsgToUser:(NSString*)receiverId andMsg:(NSString*)msgText;
-(void)getWorkoutByDate:(NSDate*)date_ andUserId:(NSString*)userId;
-(void)getImageProgress;
-(void)getHeadLine;
-(void)DeleteImage:(NSString*)receiverId;
-(void)updateWorkout:(NSString*)updateValues date:(NSDate*)date_;
-(void)GetAllWorkoutParameters;
-(void)getUserVideo:(NSString*)urlStrValue;
@end

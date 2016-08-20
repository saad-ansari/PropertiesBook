//
//  Singleton.h
//  WhoHasIHave
//
//  Created by ALI NAVEED on 1/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Singleton : NSObject {

	BOOL checkLogIn;
	
	
	
	NSMutableDictionary *userDetail;
	NSMutableArray *ItemsDetail;
	NSMutableArray *ItemsPhotosDetail;
	NSMutableArray *addphotosDetails;
	
	NSString *itemIdValue;
	BOOL Object;
	BOOL checkservices;
	BOOL checkupdate;
	BOOL messagedelete;
	BOOL UpdateIhaveItems;
	BOOL TradeCompleteBool;
	///////WhoHas
	NSMutableArray *WhoHas_itemDetails;
	NSMutableArray *WhoHas_matches;	
	
	//tradeoffer
	NSMutableArray *tradeoffer_itemdetail;
	NSMutableArray *tradeoffer_CountMsg;
	NSMutableArray *tradeoffer_CountMsg_Past;
	
	///Search W.R.T
	NSMutableArray *Search_ihave_type;
	NSMutableArray *Search_whohas_type;
	
	
	//Tabtab
	IBOutlet UITabBarController *tabBar;
	
    BOOL TrackerView;

}

@property (nonatomic, readwrite)BOOL UpdateIhaveItems,TrackerView;
@property (nonatomic, readwrite)BOOL Object;
@property (nonatomic, readwrite)BOOL messagedelete;
@property (nonatomic, readwrite)BOOL checkservices;
@property (nonatomic, readwrite)BOOL checkupdate;
@property (nonatomic, readwrite)BOOL checkLogIn;
@property (nonatomic, readwrite)BOOL TradeCompleteBool;
@property (nonatomic, retain)NSMutableDictionary *userDetail;
@property (nonatomic, retain)NSMutableArray *ItemsDetail;
@property (nonatomic, retain)NSMutableArray *addphotosDetails;
@property (nonatomic, retain)NSString *itemIdValue;
@property (nonatomic, retain)NSMutableArray *ItemsPhotosDetail;

//////WhoHas
@property (nonatomic,retain)NSMutableArray *WhoHas_itemDetails;
@property (nonatomic,retain)NSMutableArray *WhoHas_matches;
//tradeoffer
@property (nonatomic,retain)NSMutableArray *tradeoffer_itemdetail;
@property (nonatomic,retain)NSMutableArray *tradeoffer_CountMsg;
@property (nonatomic,retain)NSMutableArray *tradeoffer_CountMsg_Past;
///Search
@property (nonatomic,retain)NSMutableArray *Search_ihave_type;
@property (nonatomic,retain)NSMutableArray *Search_whohas_type;

@property (nonatomic,retain)IBOutlet UITabBarController *tabBar;

+(Singleton *)retriveSingleton;
+ (void)AlertViewsFunction:(NSString *)alertViews;
+ (BOOL)validateEmail:(NSString *)email;
+(void)saveUserData:(NSMutableDictionary*)dict;
+(NSDictionary*)getUserData;
+(void)saveSerTime:(NSString*)time_;
+(NSString*)getServerTime;
+(BOOL)connectToInternet;
@end

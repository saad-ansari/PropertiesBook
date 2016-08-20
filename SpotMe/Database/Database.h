//
//  Database.h
//  BlessingProject
//
//  Created by Ali Naveed  on 1/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Food.h"





@interface Database : NSObject {
    
    NSString *dbname,*dbPath;
    
}
-(NSMutableArray *) getFoodsList;
-(BOOL)CopyDatabaseIfNeeded;
@end

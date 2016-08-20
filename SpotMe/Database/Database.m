//
//  Database.m
//  BlessingProject
//
//  Created by Ali Naveed  on 1/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Database.h"


@implementation Database


-(id)init{
    
    NSLog(@"init mai aya");
    
    
    dbname=@"spotme.sqlite";
    
    NSArray *docspaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsdir=[docspaths objectAtIndex:0];
    dbPath=[docsdir stringByAppendingPathComponent:dbname];
    
    return self;
    
    
}
-(BOOL)CopyDatabaseIfNeeded{
    
    
    NSLog(@"copy mai aya");
    
    NSFileManager *filemgr=[NSFileManager defaultManager];
    BOOL success=[filemgr fileExistsAtPath:dbPath];
    if(success)
    {
        return YES;
        // NSLog(@"copy mai aya");
        
    }
    else
    {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath ] stringByAppendingPathComponent:dbname];
        [filemgr copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
        
        return  NO;
        
        
    }
    
}
-(NSMutableArray *) getFoodsList
{
    NSMutableArray *itemsArr1 = [[NSMutableArray alloc]init];
    sqlite3 *database;
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        NSString *Query;
        
        Query = @"select * from calories";
        const char *sqlStatement = [Query cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {  Food *Obj=[[Food alloc]init];
                
                
                Obj.itemName= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
                               
                
                Obj.itemId= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                Obj.quantity= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                Obj.unit= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                Obj.calories= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                Obj.type= [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                               
                [itemsArr1 addObject:Obj];
                // [invent_obj release];
                
                
                
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
    
    return itemsArr1;
    
}

@end
//
//  database.m
//  pray
//
//  Created by SAJID ALI RAJA on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "database.h"
static BOOL initialized = NO;
static database *sharedInstance = nil;
static NSString *DBNAME = @"book.db";
@implementation database
@synthesize db;

#pragma initial database
- (id)init {
	if(initialized)
		return sharedInstance;
	self = [super init];
    if (!self) {
		if(sharedInstance)
			[sharedInstance release];
		return nil;
	}
    [db release];
    db = [[FMDatabase databaseWithPath:[self getPath]] retain];
    if (![db open]) {
        NSLog(@"Could not open db.");
        initialized = NO;
    }else{
        initialized = YES;
    }
    db.logsErrors=YES;
	db.traceExecution=YES;
    
    return self;
}


-(void)dealloc {
	if(db)
		[db release];
	[super dealloc];
    
}
-(NSString *)getPath {
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    documentsDir = [documentsDir stringByAppendingPathComponent:DBNAME];
	return documentsDir;
}
+ (database *)sharedInstance {
    if (sharedInstance) {
        return sharedInstance;
    }
    @synchronized(self){
        sharedInstance = [[database allocWithZone:nil] init];
        
    }
    return sharedInstance;
}

///////////////*///////////////

+ (NSMutableArray *) database_getBooks
{
    NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
    @try{   
        NSString *sql = [NSString stringWithFormat:@"SELECT * From book"];
        FMResultSet *result = [[[database sharedInstance] db] executeQuery:sql];
        while ([result next]) {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setValue:[result objectForColumnName:@"bid"] forKey:@"bid"];
           [dict setValue:[result objectForColumnName:@"bdownloadid"] forKey:@"bdownloadid"];
            [dict setValue:[result objectForColumnName:@"bname"] forKey:@"bname"];
            [dict setValue:[result objectForColumnName:@"bstatus"] forKey:@"bstatus"];
            [dict setValue:[result objectForColumnName:@"subfolder"] forKey:@"subfolder"];
            [dict setValue:[result objectForColumnName:@"type"] forKey:@"type"];
            [dict setValue:[result objectForColumnName:@"uid"] forKey:@"uid"];
            [returnArray addObject:dict];
            [dict release];
            dict=nil;

           
        }
        [result close];
        result = nil;
        return returnArray;
    }
    @catch (NSException *exception) { 
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]); 
    } 
    @finally { 
        return  returnArray; 
    } 
}

+(void)database_addBook:(NSString*)bookid BookName:(NSString*)bname BookType:(NSString*)btype BookStatus:(NSString*)bstat UserID:(NSString*)uid {
       @try{
           NSString *SQL=[NSString stringWithFormat:@"INSERT INTO book (bdownloadid,bstatus,type,bname,uid) values ('%@','%@','%@','%@','%@');",bookid,bstat,btype,bname,uid];

        NSLog(@"query-->%@",SQL);
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }
    
}
+ (BOOL) database_getSpeicificBook:(NSString*)bid BookName:(NSString*)bname {
    BOOL isExist=NO;
    @try{
        NSString *sql = [NSString stringWithFormat:@"SELECT * From book WHERE bdownloadid='%@';",bid];
          NSLog(@"isexit---->%@",sql);
        FMResultSet *result = [[[database sharedInstance] db] executeQuery:sql];
        while ([result next]) {
            isExist=YES;
            
        }
        [result close];
        result = nil;
      
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
            }
    NSLog(@"isexit---->%d",isExist);
    return isExist ;

}

+ (BOOL) database_BookExist:(NSString*)bid {
    BOOL isExist=NO;
    @try{
        NSString *sql = [NSString stringWithFormat:@"SELECT * From book WHERE bdownloadid='%@';",bid];
        NSLog(@"isexit---->%@",sql);
        FMResultSet *result = [[[database sharedInstance] db] executeQuery:sql];
        while ([result next]) {
            isExist=YES;
            
        }
        [result close];
        result = nil;
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
    }
    NSLog(@"isexit---->%d",isExist);
    return isExist ;
    
}


+(void)database_downloadComplete:(NSString*)bid{
   
    @try{
        NSString *SQL=[NSString stringWithFormat:@"UPDATE book set bstatus='2' WHERE bdownloadid='%@';",bid];
        NSLog(@"query-->%@",SQL);
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }
}

+(void)database_downloadRedownload:(NSString*)bid{
    
    @try{
        NSString *SQL=[NSString stringWithFormat:@"UPDATE book set bstatus='1' WHERE bdownloadid='%@';",bid];
        NSLog(@"query-->%@",SQL);
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }
}



+(void)database_subfolder:(NSString*)bid SubFolder:(NSString*)sub{
    
    @try{
        NSString *SQL=[NSString stringWithFormat:@"UPDATE book set subfolder='%@' WHERE bdownloadid='%@';",sub,bid];
        NSLog(@"query-->%@",SQL);
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }
}
/////
+ (BOOL) database_ArticalExist:(NSString*)bid Title:(NSString*)tit {
    tit=[database convertstring:tit];
    BOOL isExist=NO;
    @try{
        NSString *sql = [NSString stringWithFormat:@"SELECT * From artical WHERE bookid='%@' AND title='%@';",bid,tit];
        NSLog(@"isexit---->%@",sql);
        FMResultSet *result = [[[database sharedInstance] db] executeQuery:sql];
        while ([result next]) {
           
            
            
            
            
            isExist=YES;
            
        }
        [result close];
        result = nil;
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
    }
    NSLog(@"isexit---->%d",isExist);
    return isExist ;
}
/////
+(void)database_addArtical:(NSString*)bookid Title:(NSString*)tit {
     tit=[database convertstring:tit];
    @try{
        NSString *SQL=[NSString stringWithFormat:@"INSERT INTO artical (bookid,title) values ('%@','%@');",bookid,tit];
        
        NSLog(@"query-->%@",SQL);
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }
    
}


+ (NSMutableArray *) database_getArtical:(NSString*)bid
{
    NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
    @try{
        NSString *sql = [NSString stringWithFormat:@"SELECT * From artical WHERE bookid='%@'",bid];
        FMResultSet *result = [[[database sharedInstance] db] executeQuery:sql];
        while ([result next]) {
            [returnArray addObject:[result objectForColumnName:@"title"]];
        }
        [result close];
        result = nil;
        return returnArray;
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        return  returnArray;
    } 
}
+(void)database_addSubScribe:(NSString*)bookid{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"dd-MMM-YYYY HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    @try{
        NSString *SQL=[NSString stringWithFormat:@"INSERT INTO subscribe (sid,sdate) values ('%@','%@');",bookid,dateStr];
        
        NSLog(@"query-->%@",SQL);
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }

}
+ (BOOL)database_SubScribeExist:(NSString*)bid {
        BOOL isExist=NO;
        @try{
            NSString *sql = [NSString stringWithFormat:@"SELECT * From subscribe WHERE sid='%@';",bid];
            NSLog(@"isexit---->%@",sql);
            FMResultSet *result = [[[database sharedInstance] db] executeQuery:sql];
            while ([result next]) {
               
                NSString *sdate=[NSString stringWithFormat:@"%@",[result objectForColumnName:@"sdate"]];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd-MMM-YYYY HH:mm:ss"];
                NSDate *ddate = [formatter dateFromString:sdate];
                NSString* dateString = [formatter stringFromDate:[NSDate date]];
                NSDate *startTime = [formatter dateFromString:dateString];
                
                NSTimeInterval interval = [startTime timeIntervalSinceDate:ddate];
                int timeSpend=interval;
                if (timeSpend>2592000) {
                  isExist=NO;
                    [database database_DeleteSubScribe:bid];
                }
                else{
                   isExist=YES;
                }
                
                
            }
            [result close];
            result = nil;
            
        }
        @catch (NSException *exception) {
            NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
        }
        @finally {
        }
        NSLog(@"isexit---->%d",isExist);
        return isExist ;
        
    }
+(void)database_DeleteSubScribe:(NSString*)bid{
    
    @try{
        NSString *SQL=[NSString stringWithFormat:@"DELETE FROM subscribe WHERE sid='%@';",bid];
        NSLog(@"query-->%@",SQL);
        
        [[[database sharedInstance] db] beginDeferredTransaction];
        [[[database sharedInstance] db] executeUpdate:SQL];
        [[[database sharedInstance] db] commit];
        
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
        
    }
    
}

//
+(NSString*)convertstring:(NSString*)str{
    
    str=[str stringByReplacingOccurrencesOfString:@"~" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"`" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"'" withString:@""];
   /* str=[str stringByReplacingOccurrencesOfString:@"#" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"$" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"^" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    str=[str stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
    str=[str stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
    str=[str stringByReplacingOccurrencesOfString:@"=" withString:@"%30"];
    str=[str stringByReplacingOccurrencesOfString:@"[" withString:@"%5B"];
    str=[str stringByReplacingOccurrencesOfString:@"]" withString:@"%5D"];
    str=[str stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
    str=[str stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
    str=[str stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
    str=[str stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
    str=[str stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
    str=[str stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    str=[str stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
    str=[str stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
    str=[str stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    str=[str stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    str=[str stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    str=[str stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    */
    
    return str;
}


@end





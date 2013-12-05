//
//  database.h
//  pray
//
//  Created by SAJID ALI RAJA on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface database : NSObject{
    
}
@property (nonatomic, retain) FMDatabase *db;
+ (database *)sharedInstance;
-(NSString *)getPath ;

+ (NSMutableArray *) database_getBooks;
+(void)database_addBook:(NSString*)bookid BookName:(NSString*)bname BookType:(NSString*)btype BookStatus:(NSString*)bstat UserID:(NSString*)uid;
+ (BOOL) database_getSpeicificBook:(NSString*)bid BookName:(NSString*)bname;
+(void)database_downloadComplete:(NSString*)bid;
+(void)database_subfolder:(NSString*)bid SubFolder:(NSString*)sub;
+ (BOOL) database_BookExist:(NSString*)bid;

+ (BOOL) database_ArticalExist:(NSString*)bid Title:(NSString*)tit;
+(void)database_addArtical:(NSString*)bookid Title:(NSString*)tit;
+ (NSMutableArray *) database_getArtical:(NSString*)bid;
+(void)database_addSubScribe:(NSString*)bookid;
+ (BOOL) database_SubScribeExist:(NSString*)bid ;
+(void)database_downloadRedownload:(NSString*)bid;
+(void)database_DeleteSubScribe:(NSString*)bid;
@end

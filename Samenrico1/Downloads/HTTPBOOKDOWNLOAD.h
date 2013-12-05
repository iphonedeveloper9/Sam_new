//
//  HTTPBOOKDOWNLOAD.h
//  Samenrico
//
//  Created by SAJID ALI on 4/16/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <Foundation/Foundation.h>
BOOL gisDownloading;
@protocol HttpBookDelegate
@optional
-(void)downloadCompleteBook:(NSString*)str;
-(void)errorOccuredBook:(NSString*)description;
-(void)percentageDownloadBook:(float)num;
@end

@interface HTTPBOOKDOWNLOAD : NSObject{
    NSString *url;
    NSString *action;
    int counter;
    id<HttpBookDelegate> delegate;
    NSURLConnection *conn;
    NSMutableData *bookData;
}

-(void)startDownload;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSString *action;
@property (nonatomic,retain) NSURLConnection *conn;
@property (nonatomic,readwrite) int counter;
@property (nonatomic,retain) id<HttpBookDelegate> delegate;
@property (atomic,retain) NSMutableData *bookData;
@property (atomic,retain) NSString *fileName;
@property (atomic,retain) NSString *bookid;
@property (retain) NSURLResponse *aresponse;
@end
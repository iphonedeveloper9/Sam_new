//
//  HTTPBOOKDOWNLOAD.m
//  Samenrico
//
//  Created by SAJID ALI on 4/16/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "HTTPBOOKDOWNLOAD.h"
#import "ZipArchive.h"
#import "database.h"
#define DEST_PATH	[NSHomeDirectory() stringByAppendingString:@"/Documents/SAM/"]



@implementation HTTPBOOKDOWNLOAD
@synthesize url;
@synthesize action;
@synthesize delegate;
@synthesize counter;
@synthesize conn;
@synthesize bookData;
@synthesize fileName;
@synthesize aresponse;
@synthesize bookid;
-(void)startDownload {
    
    if (!gisDownloading) {
        self.url=[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.url=[self.url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (request) {
            self.bookData = [[[NSMutableData alloc] init] retain];
            gisDownloading=YES;
        }
            }
}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    self.aresponse=response;
    @try {
        [self.bookData setLength:0];
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
    }
    if ([response suggestedFilename])
		self.fileName= [response suggestedFilename];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data {
    @try {
        [self.bookData appendData:data];
    }
    @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
    }
    @finally {
    }
    
	if (self.aresponse)
	{
        float expectedLength = [self.aresponse expectedContentLength];
		float currentLength = self.bookData.length;
		float percent = currentLength / expectedLength;
        
		NSLog(@"downlad percentage ->%f",percent);
        [delegate percentageDownloadBook:percent];
	}
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    gisDownloading=NO;
    NSLog(@"%@",self.fileName);
    NSString  *imagePath = [NSString stringWithFormat:@"%@%@",DEST_PATH,self.fileName];
    [self.bookData writeToFile:imagePath atomically:YES];
    connection=nil;
    [connection release];
    self.bookData=nil;
    [self.bookData release];
   /// [delegate downloadCompleteBook:self.bookid];
    NSArray *Array=[self.fileName componentsSeparatedByString:@"_"];
    NSString *str=[Array objectAtIndex:([Array count]-1)];
    str=[str stringByReplacingOccurrencesOfString:@"xml" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"zip" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
    [database database_subfolder:self.bookid SubFolder:str];

    [self unzip];

    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self.conn release];
    gisDownloading=NO;
    [delegate errorOccuredBook:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
    connection=nil;
    [connection release];
    self.bookData=nil;
    [self.bookData release];
    	
}
////
-(void)unzip{
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSString* FilePath = [NSString stringWithFormat:@"%@%@",DEST_PATH,self.fileName];
	
	NSString* SaveFile = [NSString stringWithFormat:@"%@",DEST_PATH];
	
	
    ZipArchive *zipArchive = [[ZipArchive alloc] init];
    
    if([zipArchive UnzipOpenFile:FilePath]) {
        
        if ([zipArchive UnzipFileTo:SaveFile overWrite:YES]) {
            //unzipped successfully
            NSLog(@"Archive unzip Success");
            //[self.fileManager removeItemAtPath:filePath error:NULL];
            
        } else {
            NSLog(@"Failure To Unzip Archive");             
        }
        
    } else  {
        NSLog(@"Failure To Open Archive");
    }
    
    [zipArchive release];
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager removeItemAtPath:FilePath error:NULL];
	
    
	[pool release];
    
	NSString* CompletePath = [NSString stringWithFormat:@"%@%@",DEST_PATH,self.bookid];
    
    NSURL *SaveURL= [NSURL fileURLWithPath:CompletePath];
    
    BOOL resultBackup = [self addSkipBackupAttributeToItemAtURL:SaveURL];
    
    
	NSLog(@"\nDebug ---------> End Unzip - From DownloadHelper.m.");
    NSLog(@"\nDebug ---------> File Path at: %@",DEST_PATH);
    
    NSLog(@"\nDebug ---------> Saved Book at: %@", SaveURL);
    //NSLog(@"\nDebug ---------> Do Not Backup %@", resultBackup);
	
    
	
	 [delegate downloadCompleteBook:self.bookid];
    
}
-(void) ErrorMessage:(NSString*) msg{
    NSLog(@"error---->%@",msg);
}
-(BOOL) OverWriteOperation:(NSString*) file{
	
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}


@end

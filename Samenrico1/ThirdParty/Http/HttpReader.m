//
//  HttpReader.m
//  Miriquidi
//
//  Created by Aftab Baig on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpReader.h"

@implementation HttpReader

@synthesize url;
@synthesize action;
@synthesize delegate;

NSMutableData *json;

-(void)startDownload {
    if(isDownloading){
        [self startAgain];
        return;
    }
    isDownloading=YES;
	json = [[NSMutableData data] retain];
	self.url=[self.url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSLog(@"URL---->%@",self.url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data {
	[json appendData:data];	
}
	 
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
	if (self.action == nil) {
		[delegate downloadComplete:jsonString];
	}
	else {
		[delegate downloadComplete:jsonString action:self.action];
	}
    isDownloading=NO;

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@",[error.userInfo objectForKey:@"NSLocalizedDescription"]);
	[delegate errorOccured:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
	isDownloading=NO;

}

-(void)startAgain{
    [self performSelector:@selector(startDownload) withObject:nil afterDelay:2];
    
}

@end

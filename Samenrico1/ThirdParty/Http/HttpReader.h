//
//  HttpReader.h
//  Miriquidi
//
//  Created by Aftab Baig on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDelegate.h"
BOOL isDownloading;
@interface HttpReader : NSObject {
	
	NSString *url;
	NSString *action;
	id<HttpDelegate> delegate;

}

-(void)startDownload;
-(void)startAgain;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSString *action;
@property (nonatomic,retain) id<HttpDelegate> delegate;

@end

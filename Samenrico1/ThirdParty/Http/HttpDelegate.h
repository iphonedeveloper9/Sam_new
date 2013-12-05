//
//  HttpDelegate.h
//  Miriquidi
//
//  Created by Aftab Baig on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HttpDelegate

@optional
-(void)downloadComplete:(NSString*)data;
-(void)downloadComplete:(NSString*)data action:(NSString*)action;
-(void)errorOccured:(NSString*)description;

@end



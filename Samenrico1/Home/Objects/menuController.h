//
//  menuController.h
//  Created by Muhammad Shehzad on 10/10/12.

//  Copyright (c) 2012 20thFloor Technologies. All rights reserved.
//  0092-301-8485111
// http://www.20thfloor.com/
#import <Foundation/Foundation.h>

@interface menuController : NSObject{
    
}

@property (nonatomic, retain) NSArray *arraySing;
@property (nonatomic, retain) NSDictionary *dictSig;

+ (menuController *)controller;
@end

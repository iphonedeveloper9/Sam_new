//
//  objList.m
//  Samenrico
//
//  Created by SAJID ALI on 4/19/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "objList.h"

@implementation objList
@synthesize  strTitle;
@synthesize strDescription;
@synthesize strChapter;
-(id)init{
    self.strTitle=@"";
    self.strDescription=@"";
    self.strChapter=@"";
    return self;
}
-(void)dealloc{
    [strTitle release];
    [strDescription release];
    [strChapter release];
    [super dealloc];
}
@end

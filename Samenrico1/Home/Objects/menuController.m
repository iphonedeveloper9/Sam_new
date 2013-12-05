//
//  menuController.m
//  Fusionz
//
//  Created by SAJID ALI RAJA on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "menuController.h"
static menuController *cont;
@implementation menuController
@synthesize arraySing;
@synthesize dictSig;

- (id)init
{
    self=[super init];
    if ( self  )
    {
        self.arraySing=[[NSArray alloc] init];
        self.dictSig=nil;
    }
    return self;
    
}

+ (menuController *)controller
{
        if ( !cont)
       
            cont = [[menuController alloc] init];
        
        
        return cont;
    
}

@end

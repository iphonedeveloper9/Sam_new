//
//  ImageCache.m
//  YellowJacket
//
//  Created by Wayne Cochran on 7/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"
#import "ImageCacheObject.h"

@implementation ImageCache

@synthesize totalSize;

-(id)initWithMaxSize:(NSUInteger) max  {
    if (self = [super init]) {
        totalSize = 0;
        maxSize = max;
        myDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)dealloc {
    //[myDictionary release];
    [super dealloc];
}

-(void)insertImage:(UIImage*)image withSize:(NSUInteger)sz forKey:(NSString*)key{
	//NSLog(@"--------------  new Image ---------------");
	//NSLog(@"key : %@",key);
	//NSLog(@"image : %@",image);
	//NSLog(@"image : %@, size : %d, key : %@ totalSize : %d, maxSize : %d",image, sz,key,totalSize,maxSize);
    ImageCacheObject *object = [[ImageCacheObject alloc] initWithSize:sz Image:image];
    while (totalSize + sz > maxSize) {
        NSDate *oldestTime;
        NSString *oldestKey;
        for (NSString *key in [myDictionary allKeys]) {
            ImageCacheObject *obj = [myDictionary objectForKey:key];
            if (oldestTime == nil || [obj.timeStamp compare:oldestTime] == NSOrderedAscending) {
                oldestTime = obj.timeStamp;
                oldestKey = key;
            }
        }
        if (oldestKey == nil) 
            break; // shoudn't happen
       // NSLog(@"before ImageCacheObject check...");
		ImageCacheObject *obj = [myDictionary objectForKey:oldestKey];
        totalSize -= obj.size;
        [myDictionary removeObjectForKey:oldestKey];
    }
    [myDictionary setObject:object forKey:key];
	//NSLog(@"before releasing object");
	//if(object){
		[object release];
		//object = nil;
	//}else {
	//	NSLog(@"already released");
	//}

    
}

-(UIImage*)imageForKey:(NSString*)key {
    ImageCacheObject *object = [myDictionary objectForKey:key];
    if (object == nil)
        return nil;
    [object resetTimeStamp];
    return object.image;
}

@end

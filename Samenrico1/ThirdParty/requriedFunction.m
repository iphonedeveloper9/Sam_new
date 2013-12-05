

#import "requriedFunction.h"

@implementation requriedFunction

+(UIView*)requriedFunction_Hud{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];
}

+(void)requriedFunction_Alert:(NSString*)message{
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Alert" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

+(NSString *)requriedFunction_isNULL:(NSString *)str{
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    }	
    else {
        return str;
    }
	
}
+(NSString*)requriedFunction_BaseURL{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"base_url"];
}
+(BOOL)requriedFunction_isNULLBOOL:(NSString *)str{
    if ([str isKindOfClass:[NSNull class]]) {
        return FALSE;
    }
    else {
        return YES;
    }
	
}

@end

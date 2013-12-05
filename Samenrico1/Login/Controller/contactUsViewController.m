//
//  contactUsViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/8/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "contactUsViewController.h"
#import "ASIFormDataRequest.h"
#import "requriedFunction.h"
#import "SBJSON.h"

@interface contactUsViewController ()

@end

@implementation contactUsViewController
@synthesize array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    [self requestAboutUs];
}
-(void)hud{

   // hud=[[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)acctionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)requestAboutUs{

   


    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"all_country\",\"params\":{}}"];
    //
    NSLog(@"theJson URL --- > %@%@",[requriedFunction requriedFunction_BaseURL],theJSON);
    
      
    [request setDelegate:(id)self];
    [request setRequestMethod:@"POST"];
    [request setPostValue:@"json" forKey:@"action"];
    [request setPostValue:theJSON forKey:@"requestJson"];
    [request startSynchronous];
}

#pragma mark  RequestFinished Delegate
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"data--->%@---End",[request responseString]);
    
    [hud removeFromSuperview];
	SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *data = (NSDictionary *) [parser objectWithString:[request responseString] error:nil];
    NSDictionary *info = (NSDictionary *) [data objectForKey:@"info"];
    NSLog(@"jsonRequestParser   %@",info);

     self.array =  [info objectForKey:@"country_list"];
        for (NSDictionary *d in self.array) {
            NSLog(@" %@",[d objectForKey:@"name"]);
                self.txtView=[d objectForKey:@"name"];
    
    }
    [parser release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [hud removeFromSuperview];
  	NSString* data=[request responseString] ;
	NSLog(@"data---->%@",data);
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",data] delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];
}

-(void)dealloc{
    [super dealloc];

    [_txtView release];
    [array release];
}

    

@end

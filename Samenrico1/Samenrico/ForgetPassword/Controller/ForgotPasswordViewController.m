//
//  ForgotPasswordViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/2/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "requriedFunction.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)acctionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_txtField release];
    [super dealloc];
}
- (IBAction)acctionSubmit:(id)sender {
    
    if ([self.txtField.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if(![self validateEmail:self.txtField.text]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Valid Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568)
            hud=[[[NSBundle mainBundle] loadNibNamed:@"hud6" owner:self options:nil] objectAtIndex:0];
        else
            hud=[[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];
        [self.view addSubview:hud];
        [self performSelector:@selector(loadRequest) withObject:nil afterDelay:0.1];
        [self.txtField resignFirstResponder];
    }
}
#pragma marks- validateEmail
-(BOOL)validateEmail: (NSString *) email{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:email];
	//	return TRUE;
}
-(void)loadRequest{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    NSString *theJSON = @"";
    //    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"songs_user__forgot_Password\",\"params\":{\"email\":\"%@\"}}",[requriedFunction requried_Base64:textFieldEmailAddress.text]];
    
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"forgot_password\",\"params\":{\"email\":\"%@\"}}",self.txtField.text];
    
    //
    NSLog(@"theJson URL  --- > %@",theJSON);
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
    
    if ([[info objectForKey:@"success"] isEqualToString:@"true"]) {
        
        info =  [info objectForKey:@"message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"description"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        // [alert release];
               
    }
    else{
        info =  [info objectForKey:@"message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"description"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request {
    [hud removeFromSuperview];
  	NSString* data=[request responseString] ;
	NSLog(@"data---->%@",data);
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",data] delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
    
        [alert show];
        [alert release];
   
}

#pragma mark-textFieldShouldReturn
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end

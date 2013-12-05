//
//  LoginViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ASIFormDataRequest.h"
#import "requriedFunction.h"
#import "SBJSON.h"
#import "ForgotPasswordViewController.h"
#import <Social/Social.h>
#import "twitterViewController.h"
#import "facebookViewController.h"
#import "contactUsViewController.h"
#import "shelfViewController.h"
@interface LoginViewController ()

@end
@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.shelf_btn setHidden:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSString *status = [[NSUserDefaults standardUserDefaults] stringForKey:@"title"];
    
    if ([status isEqualToString:@"Success"]) {
        NSLog(@"status is %@",status);
        [self.view addSubview:self.loginView];
        
        if ([UIScreen mainScreen].bounds.size.height==568)
            
            self.loginView.frame=CGRectMake(0,86, 320, 312);
        
        else
            
            self.loginView.frame=CGRectMake(0,86, 320, 312);
        
        [self.shelf_btn setHidden:NO];
        
        [self.btn setHidden:YES];
        
        [self.btn1 setHidden:YES];
    }
}

- (IBAction)acctionBack:(id)sender {
    [self back];
}
-(void)back{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view.window cache:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.85];
    [UIView commitAnimations];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)acctionLogin:(id)sender {
    
    if ([self.txtUserName.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your User Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if ([self.txtPassword.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568)
            hud=[[[NSBundle mainBundle] loadNibNamed:@"hud6" owner:self options:nil] objectAtIndex:0];
        else
            hud=[[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];
        [self.view addSubview:hud];
        [self performSelector:@selector(requestLogin) withObject:nil afterDelay:0.1];
        [self.txtPassword resignFirstResponder];
        [self.txtUserName resignFirstResponder];
    }
}

-(void)requestLogin{

    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"user_login\",\"params\":{\"user_name\":\"%@\",\"password\":\"%@\"}}",self.txtUserName.text,self.txtPassword.text];    //
    
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
    
  
    if ([[info objectForKey:@"success"] isEqualToString:@"true"]) {
        
        info =  [info objectForKey:@"message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"description"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
       // [alert release];
        NSString *status = [info objectForKey:@"title"];
        NSLog(@"userName  %@",status);
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:status forKey:@"title"];
        [defaults synchronize];
    }
    else
    {
        info =  [info objectForKey:@"message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"description"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        shelfViewController *shelfScreen=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
        [self.navigationController pushViewController:shelfScreen animated:YES];
        [shelfScreen release];
    }
}
- (IBAction)acctionForget:(id)sender {
    ForgotPasswordViewController *forScreen;
    if ([[UIScreen mainScreen] bounds].size.height==568)
        forScreen=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController612" bundle:nil];
    else
        forScreen=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:forScreen animated:YES];
    
    [forScreen release];
}

- (IBAction)acctionRegister:(id)sender {
    RegisterViewController *registerScreen;
        registerScreen=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];

    
    [self presentViewController:registerScreen animated:YES completion:nil];
    [registerScreen release];
   
}
#pragma mark-textFieldShouldReturn
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	if (textField==self.txtUserName) {
            
            [self.txtPassword becomeFirstResponder];
    }
    if (textField==self.txtPassword) {
     
            [self.txtPassword resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)acctionLogOut:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"title"];
    [defaults synchronize];
    [self.shelf_btn setHidden:YES];
    [self.btn setHidden:NO];
    [self.btn1 setHidden:NO];
    [self.loginView removeFromSuperview];
}

- (IBAction)acctionFacebook:(id)sender {
    
    facebookViewController *twitterScreen;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
        
        twitterScreen=[[facebookViewController alloc] initWithNibName:@"facebookViewController6" bundle:nil];
    else
        twitterScreen=[[facebookViewController alloc] initWithNibName:@"facebookViewController" bundle:nil];

    [self presentViewController:twitterScreen animated:YES completion:nil];
    [twitterScreen release];
   
    /*
     if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
                
                if (result == SLComposeViewControllerResultCancelled) {
                    
                    
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Before Post on Facebook First native Login.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    [alert release];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The posted successfully." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                    
                    [alert show];;
                }
                
                [controller dismissViewControllerAnimated:YES completion:Nil];
            };
            
            controller.completionHandler = myBlock;
            
            [controller setInitialText:[NSString stringWithFormat:@"samenrico"]];
            [controller addURL:[NSURL URLWithString:@"www.samenrico.com"]];
            //  [controller addImage:self.imgDish.image];
            [self presentViewController:controller animated:YES completion:Nil];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Before Post on facebook please login navtive from setting" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
     
     */
    
    
}
- (void)openMail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Samenrico"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects: nil];
        [mailer setToRecipients:toRecipients];
        
        /* UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
         NSData *imageData = UIImagePNGRepresentation(myImage);
         [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
         */
        NSString *emailBody =@"please check out this application \n \n www.Samenrico.com";
        [mailer setMessageBody:emailBody isHTML:NO];
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentViewController:mailer animated:YES completion:nil];
      //  [self presentModalViewController:mailer animated:YES];
     //   [[mailer navigationBar] setTintColor:[UIColor colorWithRed:17/255.0 green:155/255.0 blue:200/255.0 alpha:1]];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet.Please set Email account."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                            otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
#pragma mark - MFMailComposeController delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the Drafts folder");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
            break;
        default:
            NSLog(@"Mail not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)acctionEmail:(id)sender {
    [self openMail];
}
- (IBAction)acctionTwitter:(id)sender {
    
    twitterViewController *twitterScreen;
    if ([[UIScreen mainScreen] bounds].size.height == 568)
        
        twitterScreen=[[twitterViewController alloc] initWithNibName:@"twitterViewController6" bundle:nil];
    else
        twitterScreen=[[twitterViewController alloc] initWithNibName:@"twitterViewController" bundle:nil];
    [self presentViewController:twitterScreen animated:YES completion:nil];
    
    [twitterScreen release];
    
    
    /*
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
       // [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"samenrico"]];
        [tweetSheet addURL:[NSURL URLWithString:@"www.samenrico.com"]];

        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }*/
}
- (IBAction)acctionShelf:(id)sender {
    NSString *status = [[NSUserDefaults standardUserDefaults] stringForKey:@"title"];
    if ([status isEqualToString:@"Success"]) {
       // [self back];
      
         shelfViewController *shelfScreen=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
        [self.navigationController pushViewController:shelfScreen animated:YES];
        [shelfScreen release];
        
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Before go shelf you must login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)acctionAboutUs:(id)sender {
    
    [self openMail2];
}



-(void)openMail2{
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"inquiry"];
        
         // NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", @"secondMail@example.com", nil];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@samenrico.com", nil];
        [mailer setToRecipients:toRecipients];

        
        
        NSString *emailBody =@"";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        NSLog(@"emailBody   %@",emailBody);
       

        
        [self presentViewController:mailer animated:YES completion:nil];
        //  [self presentModalViewController:mailer animated:YES];
      //  [[mailer navigationBar] setTintColor:[UIColor colorWithRed:17/255.0 green:155/255.0 blue:200/255.0 alpha:1]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet.Please set Email account."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }



}
- (void)dealloc {
    [_txtUserName release];
    [_txtPassword release];
    [_loginView release];
    [_imgLogout release];
    [_shelf_btn release];
    [_btn release];
    [_btn1 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


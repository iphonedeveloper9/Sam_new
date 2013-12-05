//
//  RegisterViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/30/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "RegisterViewController.h"
#import "ASIFormDataRequest.h"
#import "requriedFunction.h"
#import "SBJSON.h"
#import <QuartzCore/QuartzCore.h>

#import "twitterViewController.h"
#import "facebookViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize arrCountry;
@synthesize dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark-viewDidLoad

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//    self.big_View.layer.masksToBounds = YES;
//    self.big_View.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.big_View.layer.borderWidth = 1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    runURL=1;
    
    if ([UIScreen mainScreen].bounds.size.height==568)
        hud=[[[NSBundle mainBundle] loadNibNamed:@"hud6" owner:self options:nil] objectAtIndex:0];
    else
    hud=[[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];
    
    [self.view addSubview:hud];
    [self performSelector:@selector(scrollViewAdd) withObject:nil afterDelay:0.1];
    self.arrCountry=[[NSMutableArray alloc] init];
    
    
    [self performSelector:@selector(allCoutriesRequest) withObject:nil afterDelay:0.2];
    // Do any additional setup after loading the view from its nib.
}

-(void)scrollViewAdd{
    
    [self.scrollView addSubview:self.big_View];
    self.scrollView.contentSize = CGSizeMake(0, self.big_View.frame.size.height);
    self.big_View.layer.cornerRadius = 8.0;
   // self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);
}
#pragma mark-textFieldShouldReturn
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	if (textField==self.txtFirstName) {
        
        [self.txtLastName becomeFirstResponder];
    }
    if (textField==self.txtLastName) {
        
        [self.txtMiddleName becomeFirstResponder];
    }
    
    if (textField==self.txtMiddleName) {
        
        [self.txtEmail becomeFirstResponder];
    }
    
    if (textField==self.txtEmail) {
        self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);
        
        
        [self.txtZipCode becomeFirstResponder];
    }
    
    if (textField==self.txtZipCode) {
        self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);
        
        
        [self.txtPhone becomeFirstResponder];
    }
    
    if (textField==self.txtPhone) {
        
        [self.txtAddress becomeFirstResponder];
        
    }
    if (textField==self.txtAddress) {
        self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);
        [self.txtAddress resignFirstResponder];
    }
    
    if (textField==self.lblState) {
        
        [self.lblCity becomeFirstResponder];
    }
    if (textField==self.lblCity) {
        [self.lblCity resignFirstResponder];
        self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);

    }
    if (textField==self.txtLogin) {
        [self.txtPassword becomeFirstResponder];
        
    }
    if (textField==self.txtPassword) {
        
        
        [self.txtConfPassword becomeFirstResponder];
        
    }
    if (textField==self.txtConfPassword) {
        self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);
        
        [self.txtConfPassword resignFirstResponder];
    }
    
    return YES;
}
#pragma mark-textFieldDidBeginEditing

-(void)textFieldDidBeginEditing:(UITextField *)textField    {
    
    if (textField==self.txtEmail) {
        self.big_View.frame=CGRectMake(0, -40, 300,  self.big_View.frame.size.height);
    }
    if(textField==self.txtZipCode){
        
        self.big_View.frame=CGRectMake(0, -80, 300,  self.big_View.frame.size.height);
    }
    if (textField==self.txtPhone) {
        
        self.big_View.frame=CGRectMake(0, -120, 300,  self.big_View.frame.size.height);
    }
    if (textField==self.txtAddress) {
        
        self.big_View.frame=CGRectMake(0, -150, 300,  self.big_View.frame.size.height);
        
    }
    
    if (textField==self.lblState) {
        
        self.big_View.frame=CGRectMake(0, -20, 300,  self.big_View.frame.size.height);
        
    }
    
    if (textField==self.lblCity) {
        
        self.big_View.frame=CGRectMake(0, -58, 300,  self.big_View.frame.size.height);
        
    }
    
    if (textField==self.txtLogin) {
        
        self.big_View.frame=CGRectMake(0, -160, 300,  self.big_View.frame.size.height);
    }
    if (textField==self.txtPassword) {
        
        self.big_View.frame=CGRectMake(0, -180, 300,  self.big_View.frame.size.height);
    }
    if (textField==self.txtConfPassword) {
        
        self.big_View.frame=CGRectMake(0, -200, 300,  self.big_View.frame.size.height);
        
    }
    
}

#pragma mark-IBACTION

- (IBAction)acctionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)acctionSigup:(id)sender {
    
    if ([self.txtFirstName.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your First Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if ([self.txtLastName.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Last Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if ([self.txtEmail.text isEqualToString:@""]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    else if ([self.txtZipCode.text isEqualToString:@""]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Zip Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.txtPhone.text isEqualToString:@""]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Phone Number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    else if([self.txtAddress.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.lblCity.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select Your City" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.lblState.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select Your State" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.lblCountry.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select Your Country" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.txtLogin.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your User Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.txtPassword.text isEqualToString:@""]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([self.txtConfPassword.text isEqualToString:@""]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Confirm Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if(![self validateEmail:self.txtEmail.text])
	{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Valid Email Address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
	}
    else  if (![self.txtPassword.text isEqualToString:self.txtConfPassword.text]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password confirmation mismatch" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    else{
        if ([UIScreen mainScreen].bounds.size.height==568)
            hud=[[[NSBundle mainBundle] loadNibNamed:@"hud6" owner:self options:nil] objectAtIndex:0];
        else
            hud=[[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];
        
        [self.view addSubview:hud];
        [self performSelector:@selector(requestSigup) withObject:nil afterDelay:0.1];
    }
}
-(void)allCoutriesRequest{
    runURL=1;
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
-(void)requestSigup{
    runURL=2;
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    NSString *theJSON = @"";    
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"sign_up\",\"params\":{\"first_name\":\"%@\",\"last_name\":\"%@\",\"middle_name\":\"%@\",\"address\":\"%@\",\"city\":\"%@\",\"state\":\"%@\",\"country\":\"%@\",\"zip\":\"%@\",\"phone\":\"%@\",\"email\":\"%@\",\"user_name\":\"%@\",\"password\":\"%@\"}}",self.txtFirstName.text,self.txtLastName.text,self.txtMiddleName.text,self.txtAddress.text,self.lblCity.text,self.lblState.text,self.lblCountry.text,self.txtZipCode.text,self.txtPhone.text,self.txtEmail.text,self.txtLogin.text,self.txtPassword.text];
    
    NSLog(@"theJSON-- >>> %@",theJSON);
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
    
        
        if (runURL==1) {
            
            
            self.arrCountry =  [[info objectForKey:@"country_list"] retain];
            if ([self.arrCountry count]==0) {
                NSLog(@"");
            }
            else
            {
                for (NSDictionary *d in self.arrCountry) {
                    NSLog(@" Country Name %@",[d objectForKey:@"name"]);
                }
            }
        }
        else{
            info =  [info objectForKey:@"message"];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[info objectForKey:@"title"] message:[info objectForKey:@"description"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        //[alert release];
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
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark-PickerLoad
- (void)pickerLoad {
    [self.view addSubview:self.viewPicker];
    CGRect frm= self.viewPicker.frame;
    frm.origin.y=self.view.frame.size.height+self.viewPicker.frame.size.height;
    self.viewPicker.frame=frm;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    frm.origin.y=self.view.frame.size.height-self.viewPicker.frame.size.height;
    self.viewPicker.frame=frm;
    [UIView commitAnimations];
}
- (void)PickerUnload {
    CGRect frm;
    frm=self.viewPicker.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    frm.origin.y=self.view.frame.size.height+self.viewPicker.frame.size.height;
    self.viewPicker.frame=frm;
    [UIView commitAnimations];
    [self performSelector:@selector(pickerRemove) withObject:nil afterDelay:0.5];
}
-(void)pickerRemove{
    [self.viewPicker removeFromSuperview];
}

#pragma mark-Picker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.arrCountry count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    self.dict=nil;
    self.dict=[self.arrCountry objectAtIndex:row];
    return [self.dict objectForKey:@"name"];
}
-(IBAction)PickerDone:(id)sender{
    
  //  if ([self.arrCountry count]==0) {
        
//    }
 //   else{
    NSInteger row1 = 0;
    row1 = [self.pickerCont selectedRowInComponent:0];
    self.dict=nil;
    self.dict=[self.arrCountry objectAtIndex:row1];
    self.lblCountry.text= [self.dict objectForKey:@"name"];
  //  }
    [self PickerUnload];
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
#pragma mark - MFMailComposeController delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
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
        
        twitterScreen=[[twitterViewController alloc] initWithNibName:@"twitterViewController" bundle:nil];
    else
        twitterScreen=[[twitterViewController alloc] initWithNibName:@"twitterViewController" bundle:nil];
    [self presentViewController:twitterScreen animated:YES completion:nil];
    [twitterScreen release];
    
    

}



- (IBAction)acctionShelf:(id)sender {
    NSString *status = [[NSUserDefaults standardUserDefaults] stringForKey:@"title"];
    if ([status isEqualToString:@"Success"]) {
        
        
    }
    
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Before go shelf you must login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}


-(void)openMail2{
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"inquiry"];
        
        // NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", @"secondMail@example.com", nil];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@samenrico.com", nil];
        [mailer setToRecipients:toRecipients];
        
        /* UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
         NSData *imageData = UIImagePNGRepresentation(myImage);
         [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
         */
        NSString *emailBody =@"";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        NSLog(@"emailBody   %@",emailBody);
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


#pragma marks- validateEmail
-(BOOL)validateEmail: (NSString *) email{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:email];
	//	return TRUE;
}

#pragma marks- scrollViewDidScroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.txtFirstName resignFirstResponder];
    [self.txtLastName resignFirstResponder];
    [self.txtMiddleName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtAddress resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtZipCode resignFirstResponder];
    [self.txtLogin resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtConfPassword resignFirstResponder];
    self.big_View.frame=CGRectMake(0, 0, 300,  self.big_View.frame.size.height);
}
#pragma mark-Dealloc
- (void)dealloc {
    [_scrollView release];
    [_big_View release];
    [_txtFirstName release];
    [_txtLastName release];
    [_txtMiddleName release];
    [_txtEmail release];
    [_txtZipCode release];
    [_txtPhone release];
    [_txtAddress release];
    [_lblCity release];
    [_lblState release];
    [_lblCountry release];
    [_txtLogin release];
    [_txtPassword release];
    [_txtConfPassword release];
    [_viewPicker release];
    [_pickerCont release];
    [dict release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)acctionAboutUs:(id)sender {
    [self openMail2];
}

- (IBAction)acctionCoutnry:(id)sender {
    [self pickerLoad];
    [self.txtFirstName resignFirstResponder];
    [self.txtLastName resignFirstResponder];
    [self.txtMiddleName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtAddress resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtZipCode resignFirstResponder];
    [self.txtLogin resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtConfPassword resignFirstResponder];
    [self.lblCity resignFirstResponder];
    [self.lblState resignFirstResponder];
}

@end

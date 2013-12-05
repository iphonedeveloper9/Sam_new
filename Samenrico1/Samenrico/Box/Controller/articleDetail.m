//
//  articleDetail.m
//  Samenrico
//
//  Created by SAJID ALI on 4/8/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "articleDetail.h"
#import "requriedFunction.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "requriedFunction.h"
#import "database.h"
#import "shelfViewController.h"
@interface articleDetail ()

@end

@implementation articleDetail
@synthesize imgForBook;
@synthesize array;
@synthesize strID;
@synthesize strtitle;
@synthesize strArticalTitle;
@synthesize strSubscribePrice;
@synthesize shelf;
@synthesize strBookName;
@synthesize strUserId;
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
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self performSelector:@selector(acctionGetBookDetail) withObject:nil afterDelay:0.01];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_lblPrice release];
    [_lblRelease release];
    [_lblMoreArticle release];
    [_lblDescriptions release];
    [_imgBookView release];
    [imgForBook release];
    [_lblPublisher release];
    [array release];
    [_viewPicker release];
    [_pickerCont release];
    [_lblBookName release];
    [_lblbookTitle release];
    [strArticalTitle release];
    [strtitle release];
    [_lblArticalPrice release];
    [_lblSubscribPrice release];
    [strSubscribePrice release];
    [_imgNO release];
    [shelf release];
    [_lblPushDate release];
    [_lblMagzineName release];
    [_imglogo release];
    [strBookName release];
    [_viewLaregeImage release];
    [_imgLargeImage release];
    [strUserId release];
    [super dealloc];
}
-(void)acctionGetBookDetail{
    //self.imgBookView.spinnerCenter =self.imgBookView.center;
    
      self.imgBookView.spinnerCenter = CGPointMake( self.imgBookView.frame.size.width/2,  self.imgBookView.frame.size.height/2);
    
    
    NSLog(@"imgForBook --- >>> %@",self.imgForBook);
    [self.imgBookView loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imgForBook]]];
    self.lblbookTitle.text=self.strArticalTitle;
    hud=[requriedFunction requriedFunction_Hud];
    [hud setCenter:[[self view] center]];
    [[self view] addSubview:hud];
    [self performSelector:@selector(acctionGetBookDetail2) withObject:nil afterDelay:0.01];
}
-(void)acctionGetBookDetail2{
    
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"get_article_detail\",\"params\":{\"id\":\"%@\",\"NEWSID\":\"%@\"}}",self.strID,self.strtitle];
    //
    NSLog(@"theJson URL --- > %@%@",[requriedFunction requriedFunction_BaseURL],theJSON);
    
    [request setDelegate:(id)self];
    [request setRequestMethod:@"POST"];
    [request setPostValue:@"json" forKey:@"action"];
    [request setPostValue:theJSON forKey:@"requestJson"];
    [request setTag:2];
    [request startSynchronous];
    //{"method":"search","params":{"publish_type":"book","category":"Crime,-Thrillers-and-Mystery"}}
}
///////////
- (void)requestFinished:(ASIHTTPRequest *)request {
    
    [hud removeFromSuperview];
    NSLog(@"%@",[request responseString]);

    NSString *str=[request responseString];
    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary* dict = (NSDictionary *) [parser objectWithString:str error:nil];
   dict=[dict objectForKey:@"info"];
    if ([[self.dict objectForKey:@"success"] isEqualToString:@"false"]) {
        [requriedFunction requriedFunction_Alert:@"No record found."];
        return;
    }
    NSArray* array2=[dict objectForKey:@"list"];
    //[self.tableCont reloadData];
  dict=[array2 objectAtIndex:0];
    //self.lblPrice=[
    
    
    NSString *strprice=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"article_price"]];
    if ([strprice isEqualToString:@""]) {
        strprice=@"0.0";
    }
    NSLog(@"%@",[self.dict objectForKey:@""]);
    self.lblPrice.text=[NSString stringWithFormat:@"$ %@",strprice];
    self.lblPushDate.text=[NSString stringWithFormat:@"%@ Published :  %@",[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"BYLINE"]],[dict objectForKey:@"PUBLISHEDDATE"]];
    self.lblRelease.text=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"PUBLISHEDDATE"]];
    self.lblDescriptions.text=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"NEWSDESCRIPTION"]];
    self.lblBookName.text=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"FEEDTITLE"]];
    self.lblMagzineName.text=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"magazine_name"]];
    self.strBookName=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"magazine_name"]];
    self.strUserId=[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"user_id"]];

   // self.imgBookView.spinnerCenter =self.imgBookView.center;
    


    NSLog(@"imgForBook %@",[NSString stringWithFormat:@"%@",[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"IMAGE"]]]);

    NSString *strURL=[NSString stringWithFormat:@"%@",[dict objectForKey:@"IMAGE"]];
    
    NSLog(@"PIc URl %@",strURL);
    
    if(strURL == nil || [strURL isEqualToString:@""]||[strURL isEqual:[NSNull null]]){
        
        
       self.imgNO.image=[UIImage imageNamed:@"noimage.png"];
		NSLog(@"INVALID IMAGE URL CAME");
        self.imgBookView.backgroundColor=[UIColor clearColor];
        self.imgBookView.opaque=0;
        [self.imgBookView setHidden:YES];
        
	}
    else{
    
    [self.imgBookView loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"IMAGE"]]]]];
        self.imgBookView.spinnerCenter = CGPointMake( self.imgBookView.frame.size.width/2,  self.imgBookView.frame.size.height/2);
    }
     self.lblArticalPrice.text=[NSString stringWithFormat:@"Artical Price $%@",[dict objectForKey:@"article_price"]];
    self.lblSubscribPrice.text=[NSString stringWithFormat:@"%@",self.strSubscribePrice];
    self.imglogo.spinnerCenter=CGPointMake(self.imglogo.frame.size.width/2, self.imglogo.frame.size.height/2);
    [self.imglogo loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"brand_image"]]]]];
    self.imgLargeImage.spinnerCenter=CGPointMake(self.imgLargeImage.frame.size.width/2, self.imgLargeImage.frame.size.height/2);
    [self.imgLargeImage loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[requriedFunction requriedFunction_isNULL:[dict objectForKey:@"IMAGE"]]]]];

}
- (void)requestFailed:(ASIHTTPRequest *)request {
	[hud removeFromSuperview];
	
    [requriedFunction requriedFunction_Alert:@"Error in request."];
}
///
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
    return [self.array count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    self.dict=nil;
    self.dict=[self.array objectAtIndex:row];
    
    NSString *str=[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"NEWSTITLE"]];
    return  str;
    
    
    ///return  [self.dict objectForKey:@"NEWSTITLE"];
}

-(IBAction)PickerDone:(id)sender{
    NSInteger row1;
    
    row1 = [self.pickerCont selectedRowInComponent:0];
    
    [self PickerUnload];
    
    self.dict=nil;
    self.dict=[self.array objectAtIndex:row1];
   
    self.strArticalTitle=[self.dict objectForKey:@"NEWSTITLE"];
    self.strtitle=[self.dict objectForKey:@"NEWSID"];
    [self performSelector:@selector(acctionGetBookDetail) withObject:nil afterDelay:0.01];


    
}
-(IBAction)PickerCancel:(id)sender{
    
    [self PickerUnload];
}

- (IBAction)acctionBack {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)acctionArticle {
    if ([self.array count]==0) {
        [requriedFunction requriedFunction_Alert:@"No article found"];
    }
    else{
        [self pickerLoad];
}
}
//////
-(IBAction)acctionDownload{
    if (![database database_getSpeicificBook:self.strID BookName:@""]) {
        [database database_addBook:self.strID BookName:self.strBookName BookType:@"2" BookStatus:@"1" UserID:self.strUserId];
    }
    
    if ([database database_ArticalExist:self.strID Title:self.lblbookTitle.text]) {
        [requriedFunction requriedFunction_Alert:@"This Artical already Exist"];
    }
    else{
        [database database_addArtical:self.strID Title:self.lblbookTitle.text];
    }
    if (!self.shelf)
            self.shelf=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
        [self.navigationController pushViewController:self.shelf animated:YES];
        
        
        
    }
- (IBAction)actionDownload2 {
   
    if ([database database_ArticalExist:self.strID Title:self.lblbookTitle.text]) {
        [requriedFunction requriedFunction_Alert:@"This Artical already Exist"];
    }
    else{
        NSString *str=self.lblArticalPrice.text;
        NSArray *ar=[str componentsSeparatedByString:@"$"];
        str=[NSString stringWithFormat:@"%@",[ar objectAtIndex:[ar count]-1]];
         NSLog(@"PRoduct id--->%@",str);
        ar=[str componentsSeparatedByString:@"."];
        int pri=[[NSString stringWithFormat:@"%@",[ar objectAtIndex:0]] intValue]+1;
        str=[NSString stringWithFormat:@"SAMENRICOTIER%d",pri];
        hud=[requriedFunction requriedFunction_Hud];
        [hud setCenter:[[self view] center]];
        [[self view] addSubview:hud];
        [self performSelector:@selector(purchase:) withObject:str afterDelay:.3];
        
    }
    
}
-(void)download{
    if (![database database_getSpeicificBook:self.strID BookName:@""]) {
        [database database_addBook:self.strID BookName:self.strBookName BookType:@"2" BookStatus:@"1" UserID:self.strUserId];

    }


    [database database_addArtical:self.strID Title:self.lblbookTitle.text];
    if (!self.shelf)
        self.shelf=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
    [self.navigationController pushViewController:self.shelf animated:YES];
    
}

//////
- (void)purchase:(NSString*)productId {
   
    if ([productId isEqualToString:@"SAMENRICOTIER0"]) {
        productId=@"SAMENRICOTIER1";
    }
 NSLog(@"PRoduct id--->%@",productId);
    NSSet *productIdentifiers = [NSSet setWithObject:productId];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    
    productsRequest.delegate = self;
    [productsRequest start];
    
    if([SKPaymentQueue canMakePayments]) { // We're accepting payments
        SKMutablePayment *payment = [[SKMutablePayment alloc] init];
        payment.productIdentifier = productId;
        payment.quantity = 1;
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    [requriedFunction requriedFunction_Alert:error.description];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    if ([hud superview])
        [hud removeFromSuperview];
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                //Purchase succeeded
                NSLog(@"Purchase Date=%@",transaction.transactionDate);
                NSLog(@"Transaction Identifier=%@",transaction.transactionIdentifier);
                NSLog(@"Transaction Receipt%@",transaction.transactionReceipt);
                NSLog(@"product identifier=%@",transaction.payment.productIdentifier);
                [self performSelector:@selector(download) withObject:nil afterDelay:0.0];
                break;
            case SKPaymentTransactionStateRestored:
                //User already purchased it before
                
                break;
            case SKPaymentTransactionStateFailed:
                if (transaction.error.code != SKErrorPaymentCancelled) {
                    NSLog(@"product not found");
                }
                else {
                    // [self failedTransaction:transaction];
                }
                break;
        }
        
        // Finish the transaction
        if(transaction.transactionState != SKPaymentTransactionStatePurchasing) {
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
            
        }
    }
}


- (IBAction)acctionOKLargeImage:(id)sender {
   CGRect rect;
    rect.size.width=320;
    rect.size.height=365;
    rect.origin.x=0;
    rect.origin.y=self.view.frame.size.height+20;
  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.viewLaregeImage.frame=rect;
    
    [UIView commitAnimations];
    [self performSelector:@selector(unloadViewLarge) withObject:nil afterDelay:.5];

    }

- (IBAction)acctionLargeViewLoad:(id)sender {
    CGRect rect;
    rect.size.width=0;
    rect.size.height=0;
    rect.origin.x=0;
    rect.origin.y=self.view.frame.size.height+20;
    self.viewLaregeImage.frame=rect;
    [self.view addSubview:self.viewLaregeImage];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    rect.size.width=320;
    rect.size.height=365;
    rect.origin.x=0;
   rect.origin.y=self.view.frame.size.height-365;
    self.viewLaregeImage.frame=rect;

    [UIView commitAnimations];


}
-(void)unloadViewLarge{
    [self.viewLaregeImage removeFromSuperview];
}
@end

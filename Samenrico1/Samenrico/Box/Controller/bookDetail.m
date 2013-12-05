//
//  bookDetail.m
//  Samenrico
//
//  Created by SAJID ALI on 4/2/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "bookDetail.h"
#import "requriedFunction.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "customHomeCell.h"
#import "articleDetail.h"
#import "database.h"
#import "shelfViewController.h"
#import "About_SubcribeViewController.h"

@interface bookDetail ()

@end
@implementation bookDetail

@synthesize strBookID;
@synthesize strBookType;
@synthesize array;
@synthesize dict;
@synthesize strBookPrice;
@synthesize strBookAuthor;
@synthesize imgForBook;
@synthesize arrayArticle;
@synthesize FreeArticle;
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
    
    self.array = [[NSMutableArray alloc] init];
    self.arrayArticle = [[NSMutableArray alloc] init];
    self.FreeArticle = [[NSMutableArray alloc] initWithArray:self.arrayArticle];
    
    NSLog(@"%@ %@ %@",self.imgForBook,self.strBookID,self.strBookType);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(about_scrb:)];
    tapGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
    [self.about_scrb addGestureRecognizer:tapGesture];

    [self performSelector:@selector(acctionGetBookDetail) withObject:nil afterDelay:0.01];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}

- (void)about_scrb:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"enter the subscribe");
    About_SubcribeViewController *About = [[About_SubcribeViewController alloc] initWithNibName:@"About_SubcribeViewController" bundle:nil];
    
    [self.navigationController pushViewController:About animated:YES];
    [About release];
}

-(void)acctionGetBookDetail{
    self.imgBookView.spinnerCenter =self.imgBookView.center;
    [self.imgBookView loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imgForBook]]];
    hud = [requriedFunction requriedFunction_Hud];
    [hud setCenter:[[self view] center]];
    [[self view] addSubview:hud];
    [self performSelector:@selector(acctionGetBookDetail2) withObject:nil afterDelay:0.01];
}
-(void)acctionGetBookDetail2
{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"item_detail\",\"params\":{\"id\":\"%@\",\"publish_type\":\"%@\"}}",self.strBookID,self.strBookType];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_lblEdition release];
    [_lblBookRelease release];
    [_lblBookPublisher release];
    [_lblLanguage release];
    [_lblCountry release];
    [_lblBookName release];
    [_lblPrice release];
    [_lblArtical release];
    [strBookID release];
    [strBookType release];
    [array release];
    [dict release];
    [_txtDesc release];
    [strBookPrice release];
    [strBookAuthor release];
    [_viewTable release];
    [_tableCont release];
    [imgForBook release];
    [_imgBookView release];
    [arrayArticle release];
    [FreeArticle release];
    [_viewPicker release];
    [_pickerCont release];
    [_lblSubscribe release];
    [_lblDelivery release];
    [strUserId release];
    [_tblData release];
    [_about_scrb release];
    [super dealloc];
}
/////
- (void)requestFinished:(ASIHTTPRequest *)request {

    [hud removeFromSuperview];
    NSLog(@"%@",[request responseString]);
    
            NSString *str=[request responseString];
        SBJSON *parser = [[SBJSON alloc] init];
        self.dict = (NSDictionary *) [parser objectWithString:str error:nil];
        self.dict=[self.dict objectForKey:@"info"];
    if ([[self.dict objectForKey:@"success"] isEqualToString:@"false"]) {
        [requriedFunction requriedFunction_Alert:@"No record found."];
        return;
    }

    self.array=[self.dict objectForKey:@"list"];
    
    if ([self.arrayArticle count]!=0) {
        [self.pickerCont reloadAllComponents];
    }
        //[self.tableCont reloadData];
    NSDictionary *d=[self.array objectAtIndex:0];
    //self.lblPrice=[
    self.strUserId=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"user_id"]];
    self.lblEdition.text=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"book_edition"]];
    self.lblBookRelease.text=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"book_release_date"]];
    self.lblBookPublisher.text=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"author"]];
    self.lblLanguage.text=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"language"]];
    self.lblCountry.text=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"country"]];
   self.txtDesc.text=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"this_publication"]];
    self.strBookPrice=[requriedFunction requriedFunction_isNULL:[d objectForKey:@"price"]];
    NSString *strprice=[requriedFunction requriedFunction_isNULL:self.strBookPrice];
    if ([strprice isEqualToString:@""]) {
        strprice=@"0.0";
    }
    self.lblPrice.text=[NSString stringWithFormat:@"Buy publication $%@",strprice];
     self.lblSubscribe.text=[NSString stringWithFormat:@"Subscribe $%@",[requriedFunction requriedFunction_isNULL:[d objectForKey:@"subscription_price"]]];
    self.lblDelivery.text=[NSString stringWithFormat:@"Delivered: Daily-Monthly-Price $%@",[requriedFunction requriedFunction_isNULL:[d objectForKey:@"subscription_price"]]];
    self.lblBookName.text=[requriedFunction requriedFunction_isNULL:self.strBookAuthor];
    [self.array removeAllObjects];
    if ([requriedFunction requriedFunction_isNULLBOOL:[self.dict objectForKey:@"more_book"]]) {
          self.array=[self.dict objectForKey:@"more_book"];
    }
  
    [self.tableCont reloadData];
    [self.arrayArticle removeAllObjects];
    [self.FreeArticle removeAllObjects];
    
    if ([requriedFunction requriedFunction_isNULLBOOL:[self.dict objectForKey:@"article_list"]]) {
        self.arrayArticle = [self.dict objectForKey:@"article_list"];
        
        for(int i = 1;i<[self.arrayArticle count];i++)
        {
            [self.FreeArticle  addObject:[self.arrayArticle objectAtIndex:i]];
            i++;
        }
    }
    [self.tblData reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[hud removeFromSuperview];
	
    [requriedFunction requriedFunction_Alert:@"Error in request."];
}
#pragma mark tableview

#pragma mark tableview delegate methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"self.FreeArticle >>>>> %d",[self.FreeArticle count]);
    NSLog(@"new data that arrive>>>>>>>>>>> %@",self.FreeArticle);
    if([self.FreeArticle count]>0)
    {
        return 3;//[self.FreeArticle count];
    }
    else
    {
        return [self.FreeArticle count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame = CGRectMake(10, 4, 300, 20);
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor redColor];
    lbl.shadowOffset = CGSizeMake(0.0, 1.0);
    lbl.text = [[self.FreeArticle objectAtIndex:indexPath.row]objectForKey:@"ENTRYSECTION"];
    lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [cell.contentView addSubview:lbl];
    
    UILabel *lbl1 = [[UILabel alloc]init];
    lbl1.frame = CGRectMake(10, 20, 300, 20);
    lbl1.backgroundColor = [UIColor clearColor];
    lbl1.textColor = [UIColor darkGrayColor];
    lbl1.shadowOffset = CGSizeMake(0.0, 1.0);
    lbl1.text = [[self.FreeArticle objectAtIndex:indexPath.row]objectForKey:@"NEWSTITLE"];
    lbl1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [cell.contentView addSubview:lbl1];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*articleDetail *Detatil = [[articleDetail alloc] initWithNibName:@"articleDetail" bundle:nil];
    Detatil.array = self.arrayArticle;
    //    Detatil.imgForBook=self.imgForBook;
    Detatil.strID=self.strBookID;
    Detatil.strArticalTitle=[self.dict objectForKey:@"NEWSTITLE"];
    Detatil.strtitle=[self.dict objectForKey:@"NEWSID"];
    Detatil.strSubscribePrice=self.lblSubscribe.text;
    [self.navigationController pushViewController:Detatil animated:YES];
    [Detatil release];*/
}

#pragma mark-UserDefine
- (IBAction)acctionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)acctionBookDetail:(id)sender{

    self.dict=nil;
    self.dict=[self.array objectAtIndex:[sender tag]];
    self.strBookID=[self.dict objectForKey:@"id"];
   // book.strBookType=strCat2;
    self.imgForBook=[self.dict objectForKey:@"image"];
    self.strBookPrice=[requriedFunction requriedFunction_isNULL:[self.dict objectForKey:@"price"]];
    self.strBookAuthor=[requriedFunction requriedFunction_isNULL:[self.dict objectForKey:@"title"]];
    [self acctionRemoveTable];
    [self performSelectorOnMainThread:@selector(acctionGetBookDetail) withObject:nil waitUntilDone:YES];
    
}
-(IBAction)acctionDownload{
    if ([database database_SubScribeExist:self.strBookID]) {
       
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"You are already subscribed this Book/Magazine/Newspaper.Do you want to download new articals?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
    }
    
    else{
        [database database_addSubScribe:self.strBookID];
        NSString *str=self.lblSubscribe.text;
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
      
        //[self performSelector:@selector(download) withObject:str afterDelay:.3];
    }
}
- (IBAction)actionDownload2 {
    if ([database database_SubScribeExist:self.strBookID]) {
       
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"You are already subscribed this Book/Magazine/Newspaper.Do you want to download new articals?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
    }

    else if ([database database_getSpeicificBook:self.strBookID BookName:@""]) {
        [requriedFunction requriedFunction_Alert:@"This book is already downloaded"];
    }
    else{
        NSString *str=self.lblPrice.text;
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
      //  [self performSelector:@selector(download) withObject:nil afterDelay:0.0];
        
    }

}
-(void)download{
    //if ([hud superview])
      //  [hud removeFromSuperview];
    if (![database database_getSpeicificBook:self.strBookID BookName:@""])
    [database database_addBook:self.strBookID BookName:self.lblBookName.text BookType:@"1" BookStatus:@"1" UserID:self.strUserId];
    if (!self.shelf)
        self.shelf=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
    [self.navigationController pushViewController:self.shelf animated:YES];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [database database_downloadRedownload:self.strBookID];
        if (!self.shelf)
            self.shelf=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
        [self.navigationController pushViewController:self.shelf animated:YES];
    }
    [alertView release];
}
//////
- (void)purchase:(NSString*)productId {
    NSLog(@"PRoduct id--->%@",productId);
    if ([productId isEqualToString:@"SAMENRICOTIER0"]) {
        productId=@"SAMENRICOTIER1";
    }
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
                    [database database_DeleteSubScribe:self.strBookID];
                }
                else {
                     NSLog(@"product cancel");
                     [database database_DeleteSubScribe:self.strBookID];
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

- (void)viewDidUnload {
    [self setAbout_scrb:nil];
    [super viewDidUnload];
}
@end

//
//  HomeViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "customHomeCell.h"
#import "ASIFormDataRequest.h"
#import "requriedFunction.h"
#import "SBJSON.h"
#import "menuController.h"
#import "bookDetail.h"
#import "shelfViewController.h";
#import "searchController.h"

#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define NUMBER_OF_ITEMS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 19: 12)
#define ITEM_SPACING 210

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize array;
@synthesize  dict;
@synthesize strCat;
@synthesize strSubCat;
@synthesize arrayBook;
@synthesize carousel;
@synthesize  lblMagazineTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
#pragma mark-Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array=[[NSMutableArray alloc] init];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    strCachesDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    fileManager = [NSFileManager defaultManager];
    
    carousel.type = iCarouselTypeCoverFlow2;
    
    lblMagazineTitle = [[UILabel alloc]init];
    lblMagazineTitle.backgroundColor = [UIColor clearColor];
    
    if ([[UIScreen mainScreen]bounds].size.height > 500) {
        lblMagazineTitle.frame = CGRectMake(0, 480 - appDelegate.posY, self.view.frame.size.width, 50);
    }
    else
    {
        lblMagazineTitle.frame = CGRectMake(0, 440 - appDelegate.posY, self.view.frame.size.width, 50);
    }
    lblMagazineTitle.font = [UIFont systemFontOfSize:16];
    lblMagazineTitle.textColor = [UIColor colorWithRed:57.0f/255 green:57.0f/255 blue:57.0f/255 alpha:1];
    lblMagazineTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblMagazineTitle];
    
    if ([menuController controller].dictSig==nil)
        [self performSelector:@selector(acctionGetBooks) withObject:nil afterDelay:.01];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)acctionLogin:(id)sender {
    
    LoginViewController *login;
    //    LoginViewController6
    if ([UIScreen mainScreen].bounds.size.height==568)
        login=[[LoginViewController alloc] initWithNibName:@"LoginViewController612" bundle:nil];
    else
        login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view.window cache:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.85];
    [UIView commitAnimations];
    [self.navigationController pushViewController:login animated:YES];
    [login release];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil(([self.arrayBook count]/4.0));
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	customHomeCell *cell = (customHomeCell *)[tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell)
		cell = [[[NSBundle mainBundle] loadNibNamed:@"customHomeCell" owner:self options:nil] lastObject];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"png"];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    self.dict=nil;
    self.dict=[self.arrayBook objectAtIndex:(4*indexPath.row)];
    cell.btn1.tag=4*indexPath.row;
    if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
        cell.img1.spinnerCenter =cell.img1.center;
        [cell.img1 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];
    }
    else
    {
        cell.img1.spinnerCenter = CGPointMake( cell.img1.frame.size.width/2,  cell.img1.frame.size.height/2);
        
        
        // cell.img1.spinnerCenter =cell.img1.center;
        [cell.img1 loadImageFromURL:url];
    }
    
    if (indexPath.row==floor(([self.arrayBook count]/4.0))) {
        
        
        if ([self.arrayBook count]%4>=2||[self.arrayBook count]%4==0) {
            cell.btn2.tag=(1+4*indexPath.row);
            self.dict=nil;
            self.dict=[self.arrayBook objectAtIndex:(1+4*indexPath.row)];
            if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
                cell.img2.spinnerCenter =cell.img2.center;
                [cell.img2 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];
            }
            else{
                
                cell.img2.spinnerCenter = CGPointMake( cell.img2.frame.size.width/2,  cell.img2.frame.size.height/2);
                
                //  cell.img2.spinnerCenter =cell.img2.center;
                [cell.img2 loadImageFromURL:url];
            }
        }
        if ([self.arrayBook count]%4>=3||[self.arrayBook count]%4==0) {
            cell.btn3.tag=(2+4*indexPath.row);
            self.dict=nil;
            self.dict=[self.arrayBook objectAtIndex:(2+4*indexPath.row)];
            
            
            if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
                cell.img3.spinnerCenter =cell.img3.center;
                [cell.img3 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];    }
            else{
                
                cell.img3.spinnerCenter = CGPointMake( cell.img3.frame.size.width/2,  cell.img3.frame.size.height/2);
                //   cell.img3.spinnerCenter =cell.img3.center;
                [cell.img3 loadImageFromURL:url];
                
            }
        }
        if ([self.arrayBook count]%4==0||[self.arrayBook count]%4==0) {
            cell.btn4.tag=(3+4*indexPath.row);
            self.dict=nil;
            self.dict=[self.arrayBook objectAtIndex:(3+4*indexPath.row)];
            
            
            if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
                cell.img4.spinnerCenter =cell.img4.center;
                [cell.img4 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];    }
            else{
                
                cell.img4.spinnerCenter = CGPointMake( cell.img4.frame.size.width/2,  cell.img4.frame.size.height/2);
                
                // cell.img4.spinnerCenter =cell.img4.center;
                [cell.img4 loadImageFromURL:url];
                
            }
        }
        
    }
    else{
        cell.btn2.tag=(1+4*indexPath.row);
        self.dict=nil;
        self.dict=[self.arrayBook objectAtIndex:(1+3*indexPath.row)];
        if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
            cell.img2.spinnerCenter =cell.img2.center;
            [cell.img2 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];
        }
        else{
            
            cell.img2.spinnerCenter = CGPointMake( cell.img2.frame.size.width/2,  cell.img2.frame.size.height/2);
            
            //  cell.img2.spinnerCenter =cell.img2.center;
            [cell.img2 loadImageFromURL:url];
        }
        
        
        cell.btn3.tag=(2+4*indexPath.row);
        self.dict=nil;
        self.dict=[self.arrayBook objectAtIndex:(2+4*indexPath.row)];
        
        
        if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
            cell.img3.spinnerCenter =cell.img3.center;
            [cell.img3 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];    }
        else{
            
            cell.img3.spinnerCenter = CGPointMake( cell.img3.frame.size.width/2,  cell.img3.frame.size.height/2);
            //     cell.img3.spinnerCenter =cell.img3.center;
            [cell.img3 loadImageFromURL:url];
            
        }
        cell.btn4.tag=(3+4*indexPath.row);
        self.dict=nil;
        self.dict=[self.arrayBook objectAtIndex:(3+4*indexPath.row)];
        
        
        if (![[self.dict objectForKey:@"image"] isEqualToString:@""]) {
            cell.img4.spinnerCenter =cell.img4.center;
            [cell.img4 loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image"]]]];    }
        else{
            
            
            cell.img4.spinnerCenter = CGPointMake( cell.img4.frame.size.width/2,  cell.img4.frame.size.height/2);
            
            //  cell.img4.spinnerCenter =cell.img3.center;
            [cell.img4 loadImageFromURL:url];
            
        }
        
        
    }
    [cell.btn1 addTarget:self action:@selector(acctionBookDetail:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(acctionBookDetail:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(acctionBookDetail:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn4 addTarget:self action:@selector(acctionBookDetail:) forControlEvents:UIControlEventTouchUpInside];
 	return cell;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return arrayBook.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UIButton *button = (UIButton *)view;
	if (button == nil)
	{
        button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, 200, 300);
        [button setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
        button.tag = index + 100;
		[button addTarget:self action:@selector(acctionBookDetail:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *filePath = [[arrayBook objectAtIndex:index]objectForKey:@"image"];
        NSString *dirPath = [self getDirectoryPath:filePath];
        NSString *fName = [filePath lastPathComponent];
        
        filePath = [dirPath stringByAppendingPathComponent:fName];
        
        if ([fileManager fileExistsAtPath:filePath]) {
            [button setBackgroundImage:[UIImage imageWithContentsOfFile:filePath] forState:UIControlStateNormal];
        }
        else
        {
            
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicator.alpha = 1.0;
            activityIndicator.tag = button.tag + 100;
            activityIndicator.center = CGPointMake(button.frame.size.width / 2, button.frame.size.height / 2);
            activityIndicator.hidesWhenStopped = NO;
            [button addSubview:activityIndicator];
            [activityIndicator startAnimating];
            NSURL *webURL = [[NSURL alloc] initWithString:[[arrayBook objectAtIndex:index]objectForKey:@"image"]];
            
            NSArray * urlArray = [[NSMutableArray alloc]init];
            urlArray = [[NSArray alloc] initWithObjects:webURL, [NSString stringWithFormat:@"%d", button.tag], nil];
            
            [self performSelectorInBackground:@selector(loadImageInBackground:) withObject:urlArray];
        }
	}
	
	return button;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    [self.view bringSubviewToFront:lblMagazineTitle];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-mm-yyyy"];
    NSDate *sdate = [dateFormat dateFromString:[[arrayBook objectAtIndex:aCarousel.currentItemIndex]objectForKey:@"sale_date"]];
    
    NSString *suffix = [self suffixForDayInDate:sdate];
    
    [dateFormat setDateFormat:@"MMMM d yyyy"];
    
    NSMutableString *dtStr = [NSMutableString stringWithString:[dateFormat stringFromDate:sdate]];
    [dtStr insertString:suffix atIndex:dtStr.length - 5];
    
    
    [lblMagazineTitle setText:dtStr];
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

#pragma mark private

- (NSString *)suffixForDayInDate:(NSDate *)date
{
    NSInteger day = [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSDayCalendarUnit fromDate:date] day];
    if (day % 10 == 1) {
        return @"st";
    } else if (day % 10 == 2) {
        return @"nd";
    } else if (day % 10 == 3) {
        return @"rd";
    } else {
        return @"th";
    }
}
- (void) loadImageInBackground:(NSArray *)urlAndTagReference
{
	NSData *imgData = [NSData dataWithContentsOfURL:[urlAndTagReference objectAtIndex:0]];
    
	UIImage *img    = [[UIImage alloc] initWithData:imgData];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:img, [urlAndTagReference objectAtIndex:1],[urlAndTagReference objectAtIndex:0], nil];
    
	[self performSelectorOnMainThread:@selector(assignImageToImageView:) withObject:arr waitUntilDone:YES];
}

- (void) assignImageToImageView:(NSArray *)imgAndTagReference
{
    if(imgAndTagReference.count != 0)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:[[imgAndTagReference objectAtIndex:1]integerValue]];
        [btn setBackgroundImage:(UIImage *)[imgAndTagReference objectAtIndex:0] forState:UIControlStateNormal];
        
        UIActivityIndicatorView *activity = (UIActivityIndicatorView *)[btn viewWithTag:btn.tag + 100];
        
        
        [activity removeFromSuperview];
        
        NSString *filePath = [[imgAndTagReference objectAtIndex:2] absoluteString];
        NSString *dirPath = [self getDirectoryPath:filePath];
        NSString *fName = [filePath lastPathComponent];
        filePath = [dirPath stringByAppendingPathComponent:fName];
        
        [UIImagePNGRepresentation([imgAndTagReference objectAtIndex:0]) writeToFile:filePath atomically:YES];
    }
}

-(NSString *)getDirectoryPath:(NSString *)aUrl
{
    NSURL* url = [NSURL URLWithString:[aUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *arrPath = [[NSArray alloc]init];
    arrPath = [url pathComponents];
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    BOOL isDir;
    NSError *error;
    
    for(int i = 1; i < [arrPath count] - 1; i++)
    {
        dirPath = [dirPath stringByAppendingPathComponent:[arrPath objectAtIndex:i]];
        
        fileManager = [NSFileManager defaultManager];
        
        if (([fileManager fileExistsAtPath:dirPath isDirectory:&isDir] && isDir) == FALSE)
        {
            [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
    }
    
    return dirPath;
}


#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
	//get item index for button
	NSInteger index = sender.tag - 100;
	
    [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                 message:[NSString stringWithFormat:@"You tapped button number %i", index]
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}

#pragma mark-User Define Program
- (IBAction)acctionCat {
    NSArray *arr=[[[menuController controller].dictSig allKeys] retain];
    [self.array removeAllObjects];
    for (int i=0; i<[arr count]; i++) {
        if (![[arr objectAtIndex:i] isEqualToString:@"success"])
            [self.array addObject:[arr objectAtIndex:i]];
        NSLog(@"%@",[arr objectAtIndex:i]);
    }
    intPicker=1;
    [self.pickerCont reloadAllComponents];
    [self pickerLoad];
    arr=nil;
    [arr release];
}

- (IBAction)acctionSubCat {
    NSLog(@"strcat--->%@",strCat);
    NSArray *arr=[[[menuController controller].dictSig objectForKey:strCat] retain];
    [self.array removeAllObjects];
    [self.array addObject:@"ALL"];
    for (NSDictionary *d in arr) {
        
        [self.array addObject:[d objectForKey:@"Category_Name"]];
        
    }
    intPicker=2;
    [self.pickerCont reloadAllComponents];
    [self pickerLoad];
    arr=nil;
    [arr release];
}
-(void)acctionBookDetail:(id)sender{
    
    NSString *strCat2=[self.strCat stringByReplacingOccurrencesOfString:@"s_" withString:@""];
    strCat2=[strCat2 stringByReplacingOccurrencesOfString:@"_" withString:@""];
    strCat2=[strCat2 stringByReplacingOccurrencesOfString:@"category" withString:@""];
    
    strCat2 = @"magazine";
    
    
    self.dict=nil;
    self.dict=[self.arrayBook objectAtIndex:[sender tag] - 100];
    bookDetail *book;
    
    book=[[bookDetail alloc] initWithNibName:@"bookDetail" bundle:nil];

    book.strBookID=[self.dict objectForKey:@"id"];
    book.strBookType=strCat2;
    book.imgForBook=[self.dict objectForKey:@"image"];
    book.strBookPrice=[requriedFunction requriedFunction_isNULL:[self.dict objectForKey:@"price"]];
    book.strBookAuthor=[requriedFunction requriedFunction_isNULL:[self.dict objectForKey:@"title"]];
    [self.navigationController pushViewController:book animated:YES];
    [book release];
    
    
}
-(void)acctionGetMenu{
    
    [self.hud setCenter:[[self view] center]];
    [[self view] addSubview:self.hud];
    [self performSelector:@selector(acctionGetMenu2) withObject:nil afterDelay:0.01];
    
}
-(void)acctionGetMenu2{
    
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
    theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"all_category\",\"params\":{}}"];
    //
    NSLog(@"theJson URL --- > %@%@",[requriedFunction requriedFunction_BaseURL],theJSON);
    
    [request setDelegate:(id)self];
    [request setRequestMethod:@"POST"];
    [request setPostValue:@"json" forKey:@"action"];
    [request setPostValue:theJSON forKey:@"requestJson"];
    [request setTag:1];
    [request startSynchronous];
    
}
-(void)acctionGetBooks{
    [self.hud setCenter:[[self view] center]];
    [[self view] addSubview:self.hud];
    [self performSelector:@selector(acctionGetBooks2) withObject:nil afterDelay:0.01];
}
-(void)acctionGetBooks2{
    [self.hud setCenter:[[self view] center]];
    [[self view] addSubview:self.hud];
    
    self.strCat = @"book";
    self.strSubCat = @"";
    NSString *strCat2=[self.strCat stringByReplacingOccurrencesOfString:@"s_" withString:@""];
    strCat2=[strCat2 stringByReplacingOccurrencesOfString:@"_" withString:@""];
    strCat2=[strCat2 stringByReplacingOccurrencesOfString:@"category" withString:@"magazine"];
    
    strCat2 = @"";
    
    NSLog(@"%@,%@",self.strCat,self.strSubCat);
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
    if ([self.strSubCat isEqualToString:@"ALL"]) {
        theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"search\",\"params\":{\"publish_type\":\"%@\",\"category\":\"%@\"}}",strCat2,@""];
    }
    else{
        theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"search\",\"params\":{\"publish_type\":\"%@\",\"category\":\"%@\"}}",strCat2,self.strSubCat];
    }
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

- (void)requestFinished:(ASIHTTPRequest *)request {
    [self.hud removeFromSuperview];
    NSLog(@"%@",[request responseString]);
    
    if (request.tag==1) {
        NSString *str=[request responseString];
        SBJSON *parser = [[SBJSON alloc] init];
        NSDictionary *data = (NSDictionary *) [parser objectWithString:str error:nil];
        
        
        
        [menuController controller].dictSig = [data objectForKey:@"info"];
        [menuController controller].arraySing=[[menuController controller].dictSig allKeys];
        [parser release];
        self.strCat=@"book";
        self.strSubCat=@"";
        self.lblCat.text=@"Book";
        self.lblSab.text=@"All";
        
        
        [self performSelector:@selector(acctionGetBooks) withObject:nil afterDelay:.4];
        
        
    }
    else{
        NSString *str=[request responseString];
        SBJSON *parser = [[SBJSON alloc] init];
        self.dict = (NSDictionary *) [parser objectWithString:str error:nil];
        self.dict=[self.dict objectForKey:@"info"];
        if ([[self.dict objectForKey:@"success"] isEqualToString:@"false"]) {
            [requriedFunction requriedFunction_Alert:@"No record found."];
            [self.arrayBook removeAllObjects];
            [self.tableCont reloadData];
            return;
        }
        self.arrayBook=[self.dict objectForKey:@"list"];
        
        NSLog(@"%@", arrayBook);
        
        iCarousel *ic =[[iCarousel alloc]init];
        ic.frame = CGRectMake(0, 100 - appDelegate.posY, 320, 370);
        ic.delegate = self;
        ic.dataSource = self;
        ic.backgroundColor = [UIColor clearColor];
        ic.type = iCarouselTypeCoverFlow;
        [ic scrollToItemAtIndex:self.arrayBook.count/2 animated:NO];
        
        [self.view addSubview:ic];
        [self.view bringSubviewToFront:lblMagazineTitle];
        
        
        [self.tableCont reloadData];
        
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request {
	[self.hud removeFromSuperview];
	
    [requriedFunction requriedFunction_Alert:@"Error in request."];
}

- (void)dealloc {
    [_tableCont release];
    [array release];
    [dict release];
    [_viewPicker release];
    [_pickerCont release];
    [strCat release];
    [strSubCat release];
    [_lblCat release];
    [_lblSab release];
    // [//arrayBook release];
    [_hud release];
    [_txtSearch release];
    [iCarousel release];
    [lblMagazineTitle release];
    [super dealloc];
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
    return [self.array count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *str=[NSString stringWithFormat:@"%@",[self.array objectAtIndex:row]];
    str=[str stringByReplacingOccurrencesOfString:@"_" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"category" withString:@""];
    str=[str capitalizedString];
    return  str;
}

-(IBAction)PickerDone:(id)sender{
    
    if ([self.array count]==0) {
        [self PickerUnload];
    }
    NSInteger row1;
    
    row1 = [self.pickerCont selectedRowInComponent:0];
    
    if (intPicker==1) {
        NSString *str=[[self.array objectAtIndex:row1] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        str=[str stringByReplacingOccurrencesOfString:@"category" withString:@""];
        str=[str capitalizedString];
        self.lblCat.text=str;
        self.strCat=[self.array objectAtIndex:row1];
        self.lblSab.text=@"Select Sab Cat";
    }
    else{
        self.lblSab.text=[[self.array objectAtIndex:row1] capitalizedString];
        self.strSubCat=[self.array objectAtIndex:row1];
        [self performSelector:@selector(acctionGetBooks) withObject:nil afterDelay:.4];
    }
    [self PickerUnload];
}

- (IBAction)acctionShelf {
    shelfViewController *tlist=[[shelfViewController alloc] initWithNibName:@"shelfViewController" bundle:nil];
    [self.navigationController pushViewController:tlist animated:YES];
    [tlist release];
}
-(IBAction)PickerCancel:(id)sender{
    
    [self PickerUnload];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    searchController *ser=[[searchController alloc] initWithNibName:@"searchController" bundle:nil];
    ser.strSearch=self.txtSearch.text;
    [self.navigationController pushViewController:ser animated:YES];
    return YES;
}


- (void)viewDidUnload {
[self setLblMagazineTitle:nil];
[super viewDidUnload];
}
@end

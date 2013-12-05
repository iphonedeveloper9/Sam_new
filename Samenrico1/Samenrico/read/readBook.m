//
//  readBook.m
//  Samenrico
//
//  Created by SAJID ALI on 4/18/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "readBook.h"
#import "requriedFunction.h"
#define DEST_PATH	[NSHomeDirectory() stringByAppendingString:@"/Documents/SAM/"]

@interface readBook ()

@end

@implementation readBook
@synthesize strPage;
@synthesize strTitle;
@synthesize dict;
@synthesize  counter;
@synthesize array;
@synthesize obj;
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
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self loadWeb];
    self.lblTitle.text=self.strTitle;
}
-(void)loadWeb{
    [self.lblNumber setText:[NSString stringWithFormat:@"%d-%d",(counter+1),[self.array count]]];
    self.strPage=[self.strPage stringByReplacingOccurrencesOfString:@"xml" withString:@""];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@.html",DEST_PATH,[self.dict objectForKey:@"bdownloadid"],[self.dict objectForKey:@"subfolder"],self.strPage] ;
    NSLog(@"path is--->%@",path);
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_web release];
    [_lblTitle release];
    [_lblNumber release];
    [strTitle release];
    [strPage release];
    [_btnNext release];
    
    [_btnPrevious release];
    [obj release];
    [super dealloc];
}
- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)acctionNext {
    ++counter;
    if (counter>=[self.array count]) {
        [requriedFunction requriedFunction_Alert:@"This is last artical"];
        return;
    }
    self.obj=nil;
    self.obj=[self.array objectAtIndex:counter];
    self.strPage=[NSString stringWithFormat:@"%@",obj.strChapter];
    [self loadWeb];
}

- (IBAction)acctionPrevious {
    --counter;
    if (counter<0) {
        [requriedFunction requriedFunction_Alert:@"This is first artical"];
        return;
    }
    self.obj=nil;
    self.obj=[self.array objectAtIndex:counter];
    self.strPage=[NSString stringWithFormat:@"%@",obj.strChapter];
    [self loadWeb];
}
@end

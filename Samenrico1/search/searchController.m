//
//  searchController.m
//  Samenrico
//
//  Created by SAJID ALI on 4/20/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "searchController.h"
#import "customSearchCell.h"
#import "ASIFormDataRequest.h"
#import "requriedFunction.h"
#import "SBJSON.h"
#import "bookDetail.h"
@interface searchController ()

@end

@implementation searchController
@synthesize dict;
@synthesize strSearch;
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
    self.array=[[NSMutableArray alloc]init];
     [self search];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-Table


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	customSearchCell *cell = (customSearchCell *)[tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell)
		cell = [[[NSBundle mainBundle] loadNibNamed:@"customSearchCell" owner:self options:nil] lastObject];
    
    self.dict=nil;
    self.dict=[self.array objectAtIndex:indexPath.row];
    cell.img.spinnerCenter = CGPointMake( cell.img.frame.size.width/2,  cell.img.frame.size.height/2);
  
        [cell.img loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"image_file"]]]];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"magazine_name"]];
    cell.txtDesc.text=[NSString stringWithFormat:@"%@",[self.dict objectForKey:@"description"]];
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

self.dict=nil;
self.dict=[self.array objectAtIndex:indexPath.row];
bookDetail *book;
if ([UIScreen mainScreen].bounds.size.height==568)
book=[[bookDetail alloc] initWithNibName:@"bookDetail6" bundle:nil];
else
book=[[bookDetail alloc] initWithNibName:@"bookDetail" bundle:nil];
book.strBookID=[self.dict objectForKey:@"magazine_id"];
book.strBookType=[self.dict objectForKey:@"publish_type"];
book.imgForBook=[self.dict objectForKey:@"image_file"];
book.strBookPrice=[requriedFunction requriedFunction_isNULL:[self.dict objectForKey:@"price"]];
book.strBookAuthor=[requriedFunction requriedFunction_isNULL:[self.dict objectForKey:@"magazine_name"]];
[self.navigationController pushViewController:book animated:YES];
[book release];
}
/////

-(IBAction)search{
    [self.hud setCenter:[[self view] center]];
    [[self view] addSubview:self.hud];
    [self performSelector:@selector(search2) withObject:nil afterDelay:0.01];
}
-(void)search2{
       ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[requriedFunction requriedFunction_BaseURL]]];
    
    // {"method":"songs_singers__get_Latest_updates","params":{}}
    NSString *theJSON = @"";
   
        theJSON = [theJSON stringByAppendingFormat:@"{\"method\":\"search_key\",\"params\":{\"key\":\"%@\"}}",self.strSearch];
    NSLog(@"Sear-->%@",theJSON);
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
    
   
        NSString *str=[request responseString];
        SBJSON *parser = [[SBJSON alloc] init];
        NSDictionary *data = (NSDictionary *) [parser objectWithString:str error:nil];
        
        self.dict = [data objectForKey:@"info"];
    if ([[self.dict objectForKey:@"success"] isEqualToString:@"true"]) {
        self.array=[self.dict objectForKey:@"list"];
    }
    else{
           }
[self.tableCont reloadData];

}
- (void)requestFailed:(ASIHTTPRequest *)request {
	[self.hud removeFromSuperview];
	
    [requriedFunction requriedFunction_Alert:@"Error in request."];
}


- (void)dealloc {
    [_hud release];
    [_tableCont release];
    [_txtSearch release];
    [super dealloc];
}
- (IBAction)acctionBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
   
    self.strSearch=self.txtSearch.text;
    [self search];
    
        return YES;
}

@end

//
//  tableList.m
//  Samenrico
//
//  Created by SAJID ALI on 4/18/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "tableList.h"
#import "readBook.h"
#import "objList.h"
#import "database.h"
#define DEST_PATH	[NSHomeDirectory() stringByAppendingString:@"/Documents/SAM/"]

@interface tableList ()

@end

@implementation tableList
@synthesize array;
@synthesize strTitle;
@synthesize dict;
@synthesize dict2;
@synthesize nodecontent;
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
    self.array=[[NSMutableArray alloc]init];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.lblTitle setText:[self.dict objectForKey:@"bname"]];
    
    [self.array removeAllObjects];
 self.nodecontent=[[NSMutableString alloc]init];
     NSString *xmlPath = [NSString stringWithFormat:@"%@/%@/%@/Issue%@_%@.xml",DEST_PATH,[self.dict objectForKey:@"bdownloadid"],[self.dict objectForKey:@"subfolder"],[self.dict objectForKey:@"bdownloadid"],[self.dict objectForKey:@"subfolder"]];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlParser setDelegate:(id)self];
    [xmlParser parse];
    NSLog(@"array count--->%d",[self.array count]);
    if ([self.array count]>1) {
        [self.array removeObjectAtIndex:0];
    }
    
    
    
    if ([[self.dict objectForKey:@"type"] isEqualToString:@"1"]) {
        [self.tableCont reloadData];
    }
    else{
        NSArray *arr=[[NSArray alloc]initWithArray:self.array];
        NSArray *arr2=[[database database_getArtical:[self.dict objectForKey:@"bdownloadid"]] retain];
        [self.array removeAllObjects];
        for(NSString *str in arr2){
            for (objList *list in arr) {
                if ([str rangeOfString:[self convertstring:list.strTitle]].location!=NSNotFound)
                    [self.array addObject:list];
        }
    }
        [arr release];
        [arr2 release];
        [self.tableCont reloadData];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [array release];
    [strTitle release];
    [dict release];
    [dict2 release];
    [_tableCont release];
    [_lblTitle release];
    [obj release];
    [super dealloc];
}
/////
#pragma mark NSXMLParser delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"]){
		self.obj=[[objList alloc]init];
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.nodecontent=[[NSString stringWithFormat:@"%@", string] retain];
	
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	//I am saving my nodecontent data inside the property of XMLString File class
	
	if([elementName isEqualToString:@"title"]){
		self.strTitle=[NSString stringWithFormat:@"%@",self.nodecontent];
        
        NSLog(@"elementName %@",elementName);
       
	}
    else if([elementName isEqualToString:@"link"]){
	NSString *str=[NSString stringWithFormat:@"%@",self.nodecontent];
        NSArray *arr=[str componentsSeparatedByString:@"_"];
        NSLog(@"arr count--->%d",[arr count]);
        if ([arr count]>=2) {
        
        self.obj.strTitle=[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
        }

            self.obj.strChapter=[NSString stringWithFormat:@"%@",self.nodecontent];
           	}
   	else if([elementName isEqualToString:@"description"]){
        self.obj.strDescription=[NSString stringWithFormat:@"%@",self.nodecontent];
        
	}

	if([elementName isEqualToString:@"item"]){
        
		[self.array addObject:self.obj];
		[self.obj release];
      self.obj = nil;
        	}
	
	[self.nodecontent release];
	self.nodecontent=[[NSMutableString alloc]init];
}
////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style =  UITableViewCellStyleSubtitle;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell)
		cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
    self.obj=nil;
    self.obj=[self.array objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.obj.strTitle];

    cell.detailTextLabel.font=[UIFont systemFontOfSize:12.0f];
    cell.detailTextLabel.numberOfLines=2;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",self.obj.strDescription];
	
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[self.dict objectForKey:@"bname"]);
    readBook *read=[[readBook alloc] initWithNibName:@"readBook" bundle:nil];
    read.strTitle=[self.dict objectForKey:@"bname"];
    self.obj=nil;
    self.obj=[self.array objectAtIndex:indexPath.row];
    read.strPage=[NSString stringWithFormat:@"%@",obj.strChapter];  
    if (read.array) {
        [read release];
    }
    read.array=[[NSMutableArray alloc]init];
    read.array=self.array;
    read.counter=indexPath.row;
    read.dict=self.dict;
   
    [self.navigationController pushViewController:read animated:YES];
    read.btnNext.hidden=NO;
    read.btnPrevious.hidden=NO;
    
    [read release];
}
-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)convertstring:(NSString*)str{
    
    str=[str stringByReplacingOccurrencesOfString:@"~" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"`" withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"'" withString:@""];
    /* str=[str stringByReplacingOccurrencesOfString:@"#" withString:@""];
     str=[str stringByReplacingOccurrencesOfString:@"$" withString:@""];
     str=[str stringByReplacingOccurrencesOfString:@"^" withString:@""];
     str=[str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
     str=[str stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
     str=[str stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
     str=[str stringByReplacingOccurrencesOfString:@"=" withString:@"%30"];
     str=[str stringByReplacingOccurrencesOfString:@"[" withString:@"%5B"];
     str=[str stringByReplacingOccurrencesOfString:@"]" withString:@"%5D"];
     str=[str stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
     str=[str stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
     str=[str stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
     str=[str stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
     str=[str stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
     str=[str stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
     str=[str stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
     str=[str stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
     str=[str stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
     str=[str stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
     str=[str stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
     str=[str stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
     */
    
    return str;
}



     @end

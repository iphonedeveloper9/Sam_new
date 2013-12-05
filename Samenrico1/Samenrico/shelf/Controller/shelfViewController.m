//
//  shelfViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/13/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "shelfViewController.h"
#import "customHomeCell.h"
#import "database.h"
#import "requriedFunction.h"
#import "HTTPBOOKDOWNLOAD.h"
#import "tableList.h"

#define URL_DOWNLOAD @"http://www.samenrico.com/publisher/downloadxml.php?login=false&user_id="
#define DEST_PATH	[NSHomeDirectory() stringByAppendingString:@"/Documents/SAM/"]
@interface shelfViewController ()

@end

@implementation shelfViewController
@synthesize array;
@synthesize  dict;
@synthesize arrayBook;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayBook=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.arrayBook=[database database_getBooks];
    [self.tableCont reloadData];
}
#pragma mark-Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil(([self.arrayBook count]/4.0));
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	customHomeCell *cell = (customHomeCell *)[tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell)
		cell = [[[NSBundle mainBundle] loadNibNamed:@"customHomeCell" owner:self options:nil] lastObject];
    
    NSString *path;
    
    NSURL *url;
    self.dict=nil;
    self.dict=[self.arrayBook objectAtIndex:(4*indexPath.row)];

    NSLog(@"%@",[self.dict objectForKey:@"bstatus"]);
   if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
       HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
        [down setDelegate:(id)self];
        [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
       [down setBookid:[dict objectForKey:@"bdownloadid"]];

       [down startDownload];
       [down release];
     //[self.lblDownloadPercent setCenter:cell.center];

   }
   
   path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
    
   url=[NSURL fileURLWithPath:path];
        cell.img1.spinnerCenter = CGPointMake( cell.img1.frame.size.width/2,  cell.img1.frame.size.height/2);
  
        [cell.img1 loadImageFromURL:url];
   
   
    if (indexPath.row==floor(([self.arrayBook count]/4.0))) {
        if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
            

            HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
            [down setDelegate:(id)self];
            [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
            [down setBookid:[dict objectForKey:@"bdownloadid"]];
            [down startDownload];
             [down release];
      //[self.lblDownloadPercent setCenter:cell.center];

        }

        
        if ([self.arrayBook count]%4>=2||[self.arrayBook count]%4==0) {
            cell.btn2.tag=(1+4*indexPath.row);
            self.dict=nil;
            self.dict=[self.arrayBook objectAtIndex:(1+4*indexPath.row)];
            if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {

            HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
            [down setDelegate:(id)self];
                [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
            [down setBookid:[dict objectForKey:@"bdownloadid"]];
            [down startDownload];
            [down release];
            }
            path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
            
            url=[NSURL fileURLWithPath:path];
                
                cell.img2.spinnerCenter = CGPointMake( cell.img2.frame.size.width/2,  cell.img2.frame.size.height/2);
                [cell.img2 loadImageFromURL:url];
           
        }
        if ([self.arrayBook count]%4>=3||[self.arrayBook count]%4==0) {
            cell.btn3.tag=(2+4*indexPath.row);
            self.dict=nil;
            self.dict=[self.arrayBook objectAtIndex:(2+4*indexPath.row)];
            if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
                

                HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
                [down setDelegate:(id)self];
                [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
               [down setBookid:[dict objectForKey:@"bdownloadid"]];
                [down startDownload];
                 [down release];
       //[self.lblDownloadPercent setCenter:cell.center];

            }

            
            path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
            
            url=[NSURL fileURLWithPath:path];
                cell.img3.spinnerCenter = CGPointMake( cell.img3.frame.size.width/2,  cell.img3.frame.size.height/2);
                [cell.img3 loadImageFromURL:url];
                
           
        }
        if ([self.arrayBook count]%4==0||[self.arrayBook count]%4==0) {
            cell.btn4.tag=(3+4*indexPath.row);
            self.dict=nil;
            self.dict=[self.arrayBook objectAtIndex:(3+4*indexPath.row)];
            if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
                

                HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
                [down setDelegate:(id)self];
                [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
               [down setBookid:[dict objectForKey:@"bdownloadid"]];
                [down startDownload];
                 [down release];
       //[self.lblDownloadPercent setCenter:cell.center];
            }

            path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
            
            url=[NSURL fileURLWithPath:path];
                cell.img4.spinnerCenter = CGPointMake( cell.img4.frame.size.width/2,  cell.img4.frame.size.height/2);
                
                [cell.img4 loadImageFromURL:url];
                
            }
        
    }
    else{
        cell.btn2.tag=(1+4*indexPath.row);
        self.dict=nil;
        self.dict=[self.arrayBook objectAtIndex:(1+3*indexPath.row)];
        if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
            

            HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
            [down setDelegate:(id)self];
            [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
           [down setBookid:[dict objectForKey:@"bdownloadid"]];
            [down startDownload];
             [down release];
       //[self.lblDownloadPercent setCenter:cell.center];
        }

        path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
        
        url=[NSURL fileURLWithPath:path];
            cell.img2.spinnerCenter = CGPointMake( cell.img2.frame.size.width/2,  cell.img2.frame.size.height/2);
            [cell.img2 loadImageFromURL:url];
        
        
        cell.btn3.tag=(2+4*indexPath.row);
        self.dict=nil;
        self.dict=[self.arrayBook objectAtIndex:(2+4*indexPath.row)];
        if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
            

            HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
            [down setDelegate:(id)self];
            [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
           [down setBookid:[dict objectForKey:@"bdownloadid"]];
            [down startDownload];
             [down release];
       //[self.lblDownloadPercent setCenter:cell.center];
        }

        path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
        
        url=[NSURL fileURLWithPath:path];
            
            
            cell.img3.spinnerCenter = CGPointMake( cell.img3.frame.size.width/2,  cell.img3.frame.size.height/2);
            [cell.img3 loadImageFromURL:url];
            
        
        cell.btn4.tag=(3+4*indexPath.row);
        self.dict=nil;
        self.dict=[self.arrayBook objectAtIndex:(3+4*indexPath.row)];
        if ([[self.dict objectForKey:@"bstatus"] isEqualToString:@"1"]&&!gisDownloading) {
            

            HTTPBOOKDOWNLOAD *down=[[HTTPBOOKDOWNLOAD alloc]init];
            [down setDelegate:(id)self];
            [down setUrl:[NSString stringWithFormat:@"%@%@&CLUBID=%@",URL_DOWNLOAD,[self.dict objectForKey:@"uid"],[self.dict objectForKey:@"bdownloadid"]]];
            [down setBookid:[dict objectForKey:@"bdownloadid"]];
          
             [down startDownload];
             [down release];
       //[self.lblDownloadPercent setCenter:cell.center];
        }

        path = [NSString stringWithFormat:@"%@/%@/%@/images/cover.jpg",DEST_PATH,[dict objectForKey:@"bdownloadid"],[dict objectForKey:@"subfolder"]];
        
        url=[NSURL fileURLWithPath:path];
            
            
            cell.img4.spinnerCenter = CGPointMake( cell.img4.frame.size.width/2,  cell.img4.frame.size.height/2);
            [cell.img4 loadImageFromURL:url];
            
              
        
    }
   [cell.btn1 addTarget:self action:@selector(acctionBookRead:) forControlEvents:UIControlEventTouchUpInside];
   [cell.btn2 addTarget:self action:@selector(acctionBookRead:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(acctionBookRead:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn4 addTarget:self action:@selector(acctionBookRead:) forControlEvents:UIControlEventTouchUpInside];
 	return cell;
}

-(void)acctionBookRead:(id)sender{
    self.dict=nil;
    self.dict=[self.arrayBook objectAtIndex:[sender tag]];
    tableList *list=[[tableList alloc] initWithNibName:@"tableList" bundle:nil];
    list.dict=self.dict;
    
  //  list.strTitle=[self.dict objectForKey:@"bname"];
    NSLog(@"%@",dict);
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}

- (IBAction)acctionback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
///////
-(void)downloadCompleteBook:(NSString*)str{
    gisDownloading=NO;
    NSLog(@"book id%@",str);
    str=[str stringByReplacingOccurrencesOfString:@".zip" withString:@""];
    [database database_downloadComplete:str];
    [self.lblDownloadPercent setText:@""];
    [self.arrayBook removeAllObjects];
    self.arrayBook=[database database_getBooks];
    [self.tableCont reloadData];
    
}
-(void)errorOccuredBook:(NSString*)description{
    [requriedFunction requriedFunction_Alert:description];
}
-(void)percentageDownloadBook:(float)num{
    [self.lblDownloadPercent setText:[NSString stringWithFormat:@"  %0.2f %%",num*100]];

    
}
- (void)dealloc {
    [_lblDownloadPercent release];
    [super dealloc];
}
@end

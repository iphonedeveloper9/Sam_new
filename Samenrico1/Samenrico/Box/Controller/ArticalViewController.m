//
//  AricalViewController.m
//  Samenrico
//
//  Created by B's Mac on 06/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "ArticalViewController.h"

@interface ArticalViewController ()

@end

@implementation ArticalViewController
@synthesize mainScroll, arrArticles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithAricleArray:(NSArray*)array
{
    arrArticles = array;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", arrArticles);
    
    for (int i = 0; i < arrArticles.count; i++)
    {
        UIScrollView *anArtical = [[UIScrollView alloc]init];
        anArtical.frame = CGRectMake(i * mainScroll.frame.size.width, 0, mainScroll.frame.size.width,mainScroll.frame.size.height);
        anArtical.backgroundColor = [UIColor clearColor];
        anArtical.layer.borderColor = [UIColor redColor].CGColor;
        anArtical.layer.borderWidth = 2.0f;
        [mainScroll addSubview:anArtical];

        
        UILabel *lblArtSection = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, anArtical.frame.size.width - 10, 25)];
        lblArtSection.backgroundColor = [UIColor clearColor];
        lblArtSection.textColor = [UIColor redColor];
        lblArtSection.font = [UIFont boldSystemFontOfSize:14];
        lblArtSection.text = [[arrArticles objectAtIndex:i]objectForKey:@"ENTRYSECTION"];
        [anArtical addSubview:lblArtSection];
        
        
        UILabel *lblArtTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, anArtical.frame.size.width - 10, 110)];
        lblArtTitle.backgroundColor = [UIColor clearColor];
        lblArtTitle.textColor = [UIColor blackColor];
        lblArtTitle.font = [UIFont boldSystemFontOfSize:26];
        lblArtTitle.numberOfLines = 0;
        lblArtTitle.text = [[arrArticles objectAtIndex:i]objectForKey:@"NEWSTITLE"];
        [anArtical addSubview:lblArtTitle];
        
        
        UILabel *lblArtFeed = [[UILabel alloc]initWithFrame:CGRectMake(5, 140, anArtical.frame.size.width - 10, 60)];
        lblArtFeed.backgroundColor = [UIColor clearColor];
        lblArtFeed.textColor = [UIColor blackColor];
        lblArtFeed.font = [UIFont boldSystemFontOfSize:16];
        lblArtFeed.numberOfLines = 0;
        lblArtFeed.text = [[arrArticles objectAtIndex:i]objectForKey:@"FEEDTITLE"];
        [anArtical addSubview:lblArtFeed];
        
        
        
        UIImageView *imgArticalPic = [[UIImageView alloc ]initWithFrame:CGRectMake(5, 205, anArtical.frame.size.width - 10, 280)];
        imgArticalPic.backgroundColor = [UIColor clearColor];
        [anArtical addSubview:imgArticalPic];
        
        
        
        UILabel *lblArtDetail = [[UILabel alloc]initWithFrame:CGRectMake(5, 500, anArtical.frame.size.width - 10, 60)];
        lblArtDetail.backgroundColor = [UIColor clearColor];
        lblArtDetail.textColor = [UIColor blackColor];
        lblArtDetail.font = [UIFont systemFontOfSize:16];
        lblArtDetail.numberOfLines = 0;
        lblArtDetail.text = [[arrArticles objectAtIndex:i]objectForKey:@"NEWSDESCRIPTION"];
        [anArtical addSubview:lblArtDetail];
        
        CGSize maximumLabelSize = CGSizeMake(300,9999);
        
        CGSize expectedLabelSize = [lblArtDetail.text
                                    sizeWithFont:lblArtDetail.font constrainedToSize:maximumLabelSize
                                        lineBreakMode:lblArtDetail.lineBreakMode];
        CGRect newFrame = lblArtDetail.frame;
        newFrame.size.height = expectedLabelSize.height;
        lblArtDetail.frame = newFrame;
        
        [anArtical setContentSize:CGSizeMake(anArtical.frame.size.width, lblArtDetail.frame.size.height + lblArtDetail.frame.origin.y)];
        
        
        
        
    }
    
    mainScroll.contentSize = CGSizeMake(mainScroll.frame.size.width *arrArticles.count, mainScroll.frame.size.height);
    mainScroll.pagingEnabled = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [mainScroll release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainScroll:nil];
    [super viewDidUnload];
}
@end

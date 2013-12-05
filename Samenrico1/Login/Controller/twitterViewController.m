//
//  twitterViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/3/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "twitterViewController.h"
@interface twitterViewController ()

@end
@implementation twitterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     NSString *url=@"https://twitter.com/samenricostore";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_webView release];
    [super dealloc];
}
-(void)webViewDidStartLoad:(UIWebView *) portal {
    
    if ([UIScreen mainScreen].bounds.size.height==568)
        hud=[[[NSBundle mainBundle] loadNibNamed:@"hud6" owner:self options:nil] objectAtIndex:0];
    else
        hud=[[[NSBundle mainBundle] loadNibNamed:@"hud" owner:self options:nil] objectAtIndex:0];
    [self.view addSubview:hud];
    
}

-(void)webViewDidFinishLoad:(UIWebView *) portal{
    [hud removeFromSuperview];

}

- (IBAction)acctionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

//
//  About_SubcribeViewController.m
//  Samenrico
//
//  Created by Dhaval on 03/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "About_SubcribeViewController.h"

@interface About_SubcribeViewController ()

@end

@implementation About_SubcribeViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_BackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

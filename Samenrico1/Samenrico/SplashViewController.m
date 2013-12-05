//
//  ViewController.m
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "SplashViewController.h"

#import "HomeViewController.h"


@interface SplashViewController ()
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   // [self performSelector:@selector(nextView) withObject:nil afterDelay:0.0];

    [self performSelector:@selector(animationView) withObject:nil afterDelay:2.5];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_imgLogo release];
    [super dealloc];
}
-(void)animationView{
    
    self.imgLogo.frame=CGRectMake(97, 0, 0, 0);
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    
    
    
    self.imgLogo.image=[UIImage imageNamed:@"Logo.png"];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
        
        self.imgLogo.frame=CGRectMake(97, 285-37, 127, 37);
    
    else
        
        self.imgLogo.frame=CGRectMake(97, 203, 127, 37);
    [UIView commitAnimations];
    [self performSelector:@selector(nextView) withObject:nil afterDelay:5.5];
}

-(void)nextView{
    HomeViewController *home;
    if ([[UIScreen mainScreen] bounds].size.height == 568)
        home=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    else
        home=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:home animated:YES];
    [home release];
}


@end

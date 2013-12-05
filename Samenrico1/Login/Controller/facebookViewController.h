//
//  facebookViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/3/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface facebookViewController : UIViewController{
    UIView *hud;
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)acctionBack:(id)sender;


@end

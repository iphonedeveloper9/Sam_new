//
//  LoginViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
//#import <Accounts/Accounts.h>


@interface LoginViewController : UIViewController<MFMailComposeViewControllerDelegate>{

    UIView *hud;
}
- (IBAction)acctionBack:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *txtUserName;
@property (retain, nonatomic) IBOutlet UIView *loginView;
@property (retain, nonatomic) IBOutlet UITextField *txtPassword;
@property (retain, nonatomic) IBOutlet UIImageView *imgLogout;
@property (retain, nonatomic) IBOutlet UIButton *shelf_btn;
@property (retain, nonatomic) IBOutlet UIButton *btn;
@property (retain, nonatomic) IBOutlet UIButton *btn1;

- (IBAction)acctionLogin:(id)sender;
- (IBAction)acctionForget:(id)sender;
- (IBAction)acctionRegister:(id)sender;
- (IBAction)acctionLogOut:(id)sender;
- (IBAction)acctionFacebook:(id)sender;
- (IBAction)acctionEmail:(id)sender;
- (IBAction)acctionTwitter:(id)sender;
- (IBAction)acctionShelf:(id)sender;
- (IBAction)acctionAboutUs:(id)sender;

@end

//
//  RegisterViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/30/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface RegisterViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    int intPicker;

    int runURL;
    UIView *hud;
    
    UIView *hud6;
}

@property (nonatomic,retain) NSMutableArray *arrCountry;

@property (nonatomic,retain) NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *big_View;
@property (retain, nonatomic) IBOutlet UITextField *txtFirstName;
@property (retain, nonatomic) IBOutlet UITextField *txtLastName;
@property (retain, nonatomic) IBOutlet UITextField *txtMiddleName;
@property (retain, nonatomic) IBOutlet UITextField *txtEmail;
@property (retain, nonatomic) IBOutlet UITextField *txtZipCode;
@property (retain, nonatomic) IBOutlet UITextField *txtPhone;
@property (retain, nonatomic) IBOutlet UITextField *txtAddress;
@property (retain, nonatomic) IBOutlet UITextField *lblCity;
@property (retain, nonatomic) IBOutlet UITextField *lblState;
@property (retain, nonatomic) IBOutlet UILabel *lblCountry;
@property (retain, nonatomic) IBOutlet UITextField *txtLogin;
@property (retain, nonatomic) IBOutlet UITextField *txtPassword;
@property (retain, nonatomic) IBOutlet UITextField *txtConfPassword;
@property (retain, nonatomic) IBOutlet UIView *viewPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerCont;
- (IBAction)acctionAboutUs:(id)sender;

- (IBAction)acctionCoutnry:(id)sender;
- (IBAction)PickerDone:(id)sender;
- (IBAction)acctionTwitter:(id)sender;
- (IBAction)acctionSigup:(id)sender;
- (IBAction)acctionBack:(id)sender;
- (IBAction)acctionShelf:(id)sender ;
- (IBAction)acctionEmail:(id)sender;
- (IBAction)acctionFacebook:(id)sender;
@end

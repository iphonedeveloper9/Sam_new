//
//  ForgotPasswordViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/2/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController{

    UIView *hud;
}
- (IBAction)acctionBack:(id)sender;
- (IBAction)acctionSubmit:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *txtField;

@end

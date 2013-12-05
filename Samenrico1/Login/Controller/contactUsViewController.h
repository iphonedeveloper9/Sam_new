//
//  contactUsViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/8/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactUsViewController : UIViewController{

    UIView *hud;
}
- (IBAction)acctionBack:(id)sender;

@property (nonatomic,retain) NSMutableArray *array;
@property (retain, nonatomic) IBOutlet UITextView *txtView;

@end

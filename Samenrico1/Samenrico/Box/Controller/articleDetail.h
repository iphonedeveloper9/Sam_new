//
//  articleDetail.h
//  Samenrico
//
//  Created by SAJID ALI on 4/8/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <StoreKit/StoreKit.h>
@class shelfViewController;
@interface articleDetail : UIViewController<SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    
    UIView *hud;
}

@property (retain, nonatomic) IBOutlet UILabel *lblPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblRelease;
@property (retain, nonatomic) IBOutlet UILabel *lblPublisher;
@property (retain, nonatomic) NSString* imgForBook;
@property (retain,nonatomic)  NSMutableArray *array;
@property (retain, nonatomic) IBOutlet UIView *viewPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerCont;
@property (retain, nonatomic) IBOutlet UILabel *lblBookName;
@property (retain, nonatomic) IBOutlet UIImageView *imgNO;
@property (retain, nonatomic) IBOutlet UILabel *lblMoreArticle;
@property (retain, nonatomic) IBOutlet UITextView *lblDescriptions;
@property (retain, nonatomic) IBOutlet AsyncImageView *imgBookView;
@property (retain,nonatomic)  NSDictionary *dict;

- (IBAction) PickerDone:(id)sender;
- (IBAction) PickerCancel:(id)sender;
- (IBAction) acctionBack;
- (IBAction) acctionArticle;

@property (retain, nonatomic) IBOutlet UILabel *lblbookTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblArticalPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblSubscribPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblPushDate;
@property (retain, nonatomic) IBOutlet UILabel *lblMagzineName;
@property (retain, nonatomic) NSString* strSubscribePrice;
@property (retain, nonatomic) shelfViewController *shelf;
@property (retain,nonatomic)  NSString *strID;
@property (retain,nonatomic)  NSString *strtitle;
@property (retain,nonatomic)  NSString *strArticalTitle;
- (IBAction)actionDownload2;
@property (retain, nonatomic) IBOutlet AsyncImageView *imglogo;
@property (retain,nonatomic) NSString *strBookName;
@property (retain, nonatomic) IBOutlet UIView *viewLaregeImage;

@property (retain, nonatomic) IBOutlet AsyncImageView *imgLargeImage;
- (IBAction)acctionOKLargeImage:(id)sender;
- (IBAction)acctionLargeViewLoad:(id)sender;
@property (retain, nonatomic) NSString *strUserId;
@end

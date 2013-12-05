//
//  bookDetail.h
//  Samenrico
//
//  Created by SAJID ALI on 4/2/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@class shelfViewController;
#import <StoreKit/StoreKit.h>

@interface bookDetail : UIViewController<SKProductsRequestDelegate, SKPaymentTransactionObserver>{
    UIView *hud;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tblData;
@property (retain, nonatomic) IBOutlet UIView *about_scrb;
@property(nonatomic,retain) NSString *strBookID;
@property(nonatomic,retain) NSString *strBookType;
@property(nonatomic,retain) NSString *strBookPrice;
@property(nonatomic,retain) NSString *strBookAuthor;
@property (retain, nonatomic) IBOutlet UILabel *lblEdition;
@property (retain, nonatomic) IBOutlet UILabel *lblBookRelease;
@property (retain, nonatomic) IBOutlet UILabel *lblBookPublisher;
@property (retain, nonatomic) IBOutlet UILabel *lblLanguage;
@property (retain, nonatomic) IBOutlet UILabel *lblCountry;
@property (retain, nonatomic) IBOutlet UILabel *lblBookName;
@property (retain, nonatomic) IBOutlet UILabel *lblPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblArtical;
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) NSDictionary *dict;
@property (nonatomic,retain) NSMutableArray *arrayArticle;
@property (nonatomic,retain) NSMutableArray *FreeArticle;
@property (retain, nonatomic) IBOutlet UITextView *txtDesc;

- (IBAction)acctionBack:(id)sender;
- (IBAction)acctionRemoveTable;

- (IBAction)acctionLoadTable;
@property (retain, nonatomic) IBOutlet UIView *viewTable;
@property (retain, nonatomic) IBOutlet UITableView *tableCont;

@property (retain, nonatomic)  NSString *imgForBook;
@property (retain, nonatomic) IBOutlet AsyncImageView *imgBookView;
@property (retain, nonatomic) IBOutlet UIView *viewPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerCont;
- (IBAction)acctionArticle;
-(IBAction)PickerDone:(id)sender;
-(IBAction)PickerCancel:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *lblSubscribe;
@property (retain, nonatomic) IBOutlet UILabel *lblDelivery;
@property (retain, nonatomic)  shelfViewController *shelf;
-(IBAction)acctionDownload;
- (IBAction)actionDownload2;
@property (retain, nonatomic) NSString *strUserId;


@end

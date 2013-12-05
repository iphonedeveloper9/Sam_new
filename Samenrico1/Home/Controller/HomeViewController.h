//
//  HomeViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "iCarousel.h"
#import "AppDelegate.h"

@interface HomeViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>{

    int inturl;
    int intPicker;
    
    NSString * strCachesDirectoryPath;
    NSFileManager *fileManager;
    
    AppDelegate *appDelegate;
}
@property (nonatomic,retain)  NSMutableArray *array;
@property (nonatomic,retain)  NSMutableArray *arrayBook;
@property (nonatomic,retain)  NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UITableView *tableCont;
@property (retain, nonatomic) IBOutlet UIView *viewPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *pickerCont;
@property (retain,nonatomic)  NSString *strCat;
@property (retain,nonatomic)  NSString *strSubCat;
@property (retain, nonatomic) IBOutlet UILabel *lblCat;
@property (retain, nonatomic) IBOutlet UIView *hud;
@property (retain, nonatomic) IBOutlet UILabel *lblSab;
@property (retain, nonatomic) IBOutlet UITextField *txtSearch;
@property (retain, nonatomic) IBOutlet iCarousel *carousel;

@property (retain, nonatomic) IBOutlet UILabel *lblMagazineTitle;

-(IBAction)acctionLogin:(id)sender;
-(IBAction)acctionCat;
-(IBAction)acctionSubCat;
-(IBAction)PickerCancel:(id)sender;
-(IBAction)PickerDone:(id)sender;
-(IBAction)acctionShelf;
-(void)acctionBookDetail:(id)sender;


@end

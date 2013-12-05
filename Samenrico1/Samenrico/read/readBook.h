//
//  readBook.h
//  Samenrico
//
//  Created by SAJID ALI on 4/18/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objList.h"
@interface readBook : UIViewController{
    
}
@property (retain, nonatomic) IBOutlet UIWebView *web;
- (IBAction)back;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblNumber;
@property(nonatomic,retain) NSString *strPage;
@property(nonatomic,retain) NSString *strTitle;
@property(nonatomic,retain) NSDictionary *dict;
@property(nonatomic,assign) int counter;
@property (nonatomic,retain) NSMutableArray *array;
@property (retain, nonatomic) IBOutlet UIButton *btnNext;
@property (retain, nonatomic) IBOutlet UIButton *btnPrevious;
@property (retain, nonatomic) objList *obj;
- (IBAction)acctionNext;
- (IBAction)acctionPrevious;

@end

//
//  searchController.h
//  Samenrico
//
//  Created by SAJID ALI on 4/20/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchController : UIViewController{
    
}
@property (retain, nonatomic) IBOutlet UIView *hud;
@property(nonatomic,retain) NSMutableArray *array;
@property(nonatomic,retain) NSDictionary *dict;
@property(nonatomic,retain) NSString *strSearch;
@property (retain, nonatomic) IBOutlet UITableView *tableCont;

- (IBAction)acctionBack;
@property (retain, nonatomic) IBOutlet UITextField *txtSearch;


@end

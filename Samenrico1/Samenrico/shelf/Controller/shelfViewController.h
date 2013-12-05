//
//  shelfViewController.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 4/13/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shelfViewController : UIViewController{

}

@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) NSMutableArray *arrayBook;
@property (nonatomic,retain) NSDictionary *dict;
@property (retain, nonatomic) IBOutlet UITableView *tableCont;

- (IBAction)acctionback:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *lblDownloadPercent;




@end

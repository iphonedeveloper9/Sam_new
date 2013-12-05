//
//  tableList.h
//  Samenrico
//
//  Created by SAJID ALI on 4/18/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objList.h"
@interface tableList : UIViewController{
    NSMutableString *nodecontent;
}
@property(nonatomic,retain) NSMutableArray *array;
@property(nonatomic,retain) NSString *strTitle;
@property(nonatomic,retain) NSDictionary *dict;
@property(nonatomic,retain) NSDictionary *dict2;
@property (retain, nonatomic) IBOutlet UITableView *tableCont;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic)  NSMutableString *nodecontent;
@property (retain, nonatomic) objList *obj;
-(IBAction)back;
@end

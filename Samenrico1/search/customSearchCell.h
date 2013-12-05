//
//  customSearchCell.h
//  Samenrico
//
//  Created by SAJID ALI on 4/20/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface customSearchCell : UITableViewCell{
    
}
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet AsyncImageView *img;
@property (retain, nonatomic) IBOutlet UITextView *txtDesc;

@end

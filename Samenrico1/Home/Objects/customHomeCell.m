//
//  customHomeCell.m
//  Samenrico
//
//  Created by SAJID ALI on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "customHomeCell.h"

@implementation customHomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_img1 release];
    [_img2 release];
    [_img3 release];
    [_btn1 release];
    [_btn2 release];
    [_btn3 release];
    [_img4 release];
    [_btn4 release];
    [super dealloc];
}
@end

//
//  customSearchCell.m
//  Samenrico
//
//  Created by SAJID ALI on 4/20/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import "customSearchCell.h"

@implementation customSearchCell

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
    [_lblTitle release];
    [_img release];
    [_txtDesc release];
    [super dealloc];
}
@end

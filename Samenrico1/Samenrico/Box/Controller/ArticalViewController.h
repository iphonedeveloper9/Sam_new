//
//  AricalViewController.h
//  Samenrico
//
//  Created by B's Mac on 06/12/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticalViewController : UIViewController
{
    
}
-(id)initWithAricleArray:(NSArray*)array;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (nonatomic, retain)NSArray *arrArticles;
@end

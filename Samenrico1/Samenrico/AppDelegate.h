//
//  AppDelegate.h
//  Samenrico
//
//  Created by Muhammad Shahzad on 3/29/13.
//  Copyright (c) 2013 Muhammad Shahzad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SplashViewController *viewController;
@property(nonatomic, readwrite) int posY;

@end

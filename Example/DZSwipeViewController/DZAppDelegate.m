//
//  DZAppDelegate.m
//  DZSwipeViewController
//
//  Created by CocoaPods on 03/28/2015.
//  Copyright (c) 2014 stonedong. All rights reserved.
//

#import "DZAppDelegate.h"
#import "DZSwipeViewController.h"
#import "DZFirstViewController.h"
#import "DZSencondViewController.h"
@implementation DZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DZFirstViewController* fvc = [DZFirstViewController new];
    fvc.swipeTitle = @"xxx";
    DZSencondViewController* sVC = [DZSencondViewController new];
    sVC.swipeTitle = @"yyy";
    DZFirstViewController* tvc = [DZFirstViewController new];
    tvc.swipeTitle = @"777";
    
    
    UIView* aView = [UIView new];
    aView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 300);
    DZSwipeViewController* swipVC = [[DZSwipeViewController alloc] initWithViewControllers:@[fvc , sVC, tvc]];
    swipVC.topView = aView;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = swipVC;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end

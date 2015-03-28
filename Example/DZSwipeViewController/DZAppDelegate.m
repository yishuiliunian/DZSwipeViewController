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
    sVC.swipeTitle = @"yyyy";
    DZFirstViewController* tvc = [DZFirstViewController new];
    tvc.swipeTitle = @"777";
    DZSwipeViewController* swipVC = [[DZSwipeViewController alloc] initWithViewControllers:@[fvc , sVC, tvc]];
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

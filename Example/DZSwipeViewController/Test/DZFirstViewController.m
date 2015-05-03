//
//  DZFirstViewController.m
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "DZFirstViewController.h"
#import <UIViewController+DZSwipeViewController.h>
@implementation DZFirstViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addSwipeValue:@"xx" forKey:@"xxx"];
}
- (UIScrollView*) swipeInnerScrollView
{
    return self.tableView;
}
@end

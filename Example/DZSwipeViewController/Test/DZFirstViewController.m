//
//  DZFirstViewController.m
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "DZFirstViewController.h"

@implementation DZFirstViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (UIScrollView*) swipInnerScrollView
{
    return self.tableView;
}
@end

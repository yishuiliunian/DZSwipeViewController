//
//  UIViewController+DZSwipeViewController.h
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/5.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZSwipeViewController;
@interface UIViewController (DZSwipeViewController)
@property (nonatomic, strong) NSString* swipeTitle;
@property (nonatomic, strong) UIImage* swipeImage;
@property (nonatomic, strong, readonly) DZSwipeViewController* swipeViewController;
@end

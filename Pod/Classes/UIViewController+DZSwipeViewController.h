//
//  UIViewController+DZSwipeViewController.h
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/5.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>
extern void const * kDZViewSwiperTabItem;
@class DZTabViewItem;
@class DZSwipeViewController;
@interface UIViewController (DZSwipeViewController)
@property (nonatomic, strong) NSString* swipeTitle;
@property (nonatomic, strong) UIImage* swipeImage;
@property (nonatomic, strong) UIImage* swipeSelectedImage;
@property (nonatomic, strong, readonly) NSDictionary* swipeInfos;
@property (nonatomic, strong, readonly) DZSwipeViewController* swipeViewController;
@property (nonatomic, weak, readonly) DZTabViewItem* swipeTabItem;

- (void) addSwipeValue:(NSObject*)value forKey:(NSString*)key;
@end

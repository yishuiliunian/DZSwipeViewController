//
//  UIViewController+DZSwipeViewController.m
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/5.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "UIViewController+DZSwipeViewController.h"
#import "DZSwipeViewController.h"
#import <objc/runtime.h>
void const* kDZSwipeTitle = &kDZSwipeTitle;
void const* kDZSwipeImage = &kDZSwipeImage;
@implementation UIViewController (DZSwipeViewController)

- (void) setSwipeTitle:(NSString *)swipeTitle
{
    objc_setAssociatedObject(self, kDZSwipeTitle, swipeTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) setSwipeImage:(NSString *)swipeImage
{
    objc_setAssociatedObject(self, kDZSwipeImage, swipeImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*) swipeTitle
{
    return objc_getAssociatedObject(self, kDZSwipeTitle);
}

- (UIImage*) swipeImage
{
    return objc_getAssociatedObject(self, kDZSwipeImage);
}

- (DZSwipeViewController*) swipeViewController
{
    if ([self isKindOfClass:[DZSwipeViewController class]]) {
        return (DZSwipeViewController*)self;
    }
    if (!self.parentViewController) {
        return nil;
    }
    return self.parentViewController.swipeViewController;
}

@end
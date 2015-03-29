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
#import "DZTabViewItem.h"
void const* kDZSwipeTitle = &kDZSwipeTitle;
void const* kDZSwipeImage = &kDZSwipeImage;
void const* kDZSwipeInfos = &kDZSwipeInfos;
void const * kDZViewSwiperTabItem = &kDZViewSwiperTabItem;
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



- (DZTabViewItem*) swipeTabItem
{
    return objc_getAssociatedObject(self, kDZViewSwiperTabItem);
}

- (NSMutableDictionary*) mutableSwipeInfos
{
    NSMutableDictionary* dic = objc_getAssociatedObject(self, kDZSwipeInfos);
    if (!dic) {
        dic = [NSMutableDictionary new];
        [self setMutableSwipeInfos:dic];
    }
    return dic;
}

- (NSDictionary*) swipeInfos
{
    return [self mutableSwipeInfos];
}

- (void) addSwipeValue:(NSObject*)value forKey:(NSString*)key
{
    if (!key) {
        return;
    }
    NSMutableDictionary* infos = [self mutableSwipeInfos];
    if (value) {
        infos[key] = value;
        [self.swipeTabItem.contentView swipeInfoChangedValue:value forKey:key];
    } else {
        [infos removeObjectForKey:key];
        [self.swipeTabItem.contentView swipeInfoChangedValue:nil forKey:key];
    }
}
- (void) setMutableSwipeInfos:(NSMutableDictionary *)swipeInfos
{
    objc_setAssociatedObject(self, kDZSwipeInfos, swipeInfos, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
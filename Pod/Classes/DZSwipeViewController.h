//
//  DZSwipeViewController.h
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "DZTabView.h"
#import "UIViewController+DZSwipeViewController.h"
@interface DZSwipeViewController : UIViewController
@property (nonatomic, strong, readonly) UIPageViewController* pageViewController;
@property (nonatomic, strong, readonly) DZTabView* tabView;
@property (nonatomic, strong) Class tabItemContentViewClass;
- (instancetype) initWithViewControllers:(NSArray*)viewControllers;
@end

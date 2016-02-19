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
@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong, readonly) UIPageViewController* pageViewController;
@property (nonatomic, strong, readonly) DZTabView* tabView;
@property (nonatomic, strong, readonly) UIViewController* activeViewController;
@property (nonatomic, assign) CGFloat tabViewHeight;
@property (nonatomic, strong) Class tabItemContentViewClass;
@property (nonatomic, assign) BOOL scrollEnable;
- (instancetype) initWithViewControllers:(NSArray*)viewControllers;
@end


@interface DZSwipeViewController (SubClass)

- (void) didSwipeToViewController:(UIViewController*)vc;

@end

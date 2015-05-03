//
//  DZSwipeViewController.m
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import "DZSwipeViewController.h"
#import "DZTabViewItem.h"
#import <objc/runtime.h>
#import "UIViewController+DZSwipeViewController.h"
#import "DZTabViewItem_Private.h"
#import <DZGeometryTools.h>


CGFloat __MUTopBannerOffset()
{
    static CGFloat offset = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (DeviceSystemMajorVersion() > 6.99) {
            offset = 20;
        }
        else {
            offset = 0;
        }
    });
    return offset;
}


#define MUTopBannerOffset __MUTopBannerOffset()

@interface UIScrollView (Inner)
@property (nonatomic, assign) BOOL changingContentOffSet;
@end


static void* kUIScrollViewContentOffset = &kUIScrollViewContentOffset;
@implementation UIScrollView (Inner)

- (void) setChangingContentOffSet:(BOOL)changingContentOffSet
{
    objc_setAssociatedObject(self, kUIScrollViewContentOffset, @(changingContentOffSet), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL) changingContentOffSet
{
    NSNumber* changing = objc_getAssociatedObject(self, kUIScrollViewContentOffset);
    if (!changing) {
        return NO;
    }
    return [changing boolValue];
}

@end

@interface UIViewController (SwipeInner)
@end

@implementation UIViewController (SwipeInner)


- (void) setSwipeTabItem:(DZTabViewItem *)swipeTabItem
{
    objc_setAssociatedObject(self, kDZViewSwiperTabItem, swipeTabItem, OBJC_ASSOCIATION_ASSIGN);
}

@end

CGFloat const kDZTabHeight = 44;
@interface DZSwipeViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, DZTabViewDelegate, UIScrollViewDelegate>
{
    NSArray* _viewControllers;
    NSInteger _currentPageIndex;
    BOOL _tapTabbarAnimating;
    UIPanGestureRecognizer* _tapGestrueRecognier;
    
    CGFloat _topOffSet;
    CGFloat _topViewHeight;
    CGFloat _contentViewHeight;
    
    
    CGPoint _beginPoint;
    
    BOOL _animating;
    BOOL _firstLoadFrame;
}
@property (nonatomic, assign) BOOL tapTabbarAnimating;
@property (nonatomic, assign) NSInteger currentPageIndex;
@end
@implementation DZSwipeViewController
@synthesize pageViewController = _pageViewController;
@synthesize tabView = _tabView;
- (void) dealloc
{
    [self removeObserverForChildScrollView];
}
- (instancetype) initWithViewControllers:(NSArray*)viewControllers
{
    self = [super init];
    if (!self) {
        return self;
    }
    _viewControllers = viewControllers;
    return self;
}
- (void) dz_addChildViewController:(UIViewController*)vc
{
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
}
- (UIPageViewController*) pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self syncScrollView];
        
    }
    return _pageViewController;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
- (void) addObserverForChildScrollView
{
    for (UIViewController* vc in _viewControllers) {
        if ([vc respondsToSelector:@selector(swipeInnerScrollView)]) {
            UIScrollView* scrollView = [vc performSelector:@selector(swipeInnerScrollView)];
            [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
}

- (void) removeObserverForChildScrollView
{
    for (UIViewController* vc in _viewControllers) {
        if ([vc respondsToSelector:@selector(swipeInnerScrollView)]) {
            UIScrollView* scrollView = [vc performSelector:@selector(swipeInnerScrollView)];
            [scrollView removeObserver:self forKeyPath:@"contentOffset"];
        }
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && [object isKindOfClass:[UIScrollView class]]) {
        UIScrollView* scrollView = (UIScrollView*)object;
        
        
        CGPoint  offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        UIViewController* viewController = _viewControllers[_currentPageIndex];
        if (![viewController respondsToSelector:@selector(swipeInnerScrollView)]) {
            return;
        } else {
            UIScrollView* scrollView =  [viewController performSelector:@selector(swipeInnerScrollView)];
            if (object != scrollView) {
                return;
            }
        }
        if (scrollView.changingContentOffSet) {
            return;
        }
        CGFloat yOffSet = -offset.y;
        //        if (offset.y < 0  && CGRectGetMinY(_topView.frame) < 20) {
        //            scrollView.changingContentOffSet = YES;
        //            scrollView.contentOffset = CGPointMake(20 , 0);
        //            scrollView.changingContentOffSet = NO;
        //        }
        scrollView.changingContentOffSet = YES;
        [self moveStepOffset:yOffSet - scrollView.contentInset.top];
        scrollView.changingContentOffSet = NO;
    }
}
#pragma clang diagnostic pop
- (DZTabView*) tabView
{
    if (!_tabView) {
        _tabView = [[DZTabView alloc] init];
        _tabView.delegate = self;
    }
    return _tabView;
}

- (void) setTabViewHeight:(CGFloat)tabViewHeight
{
    _tabViewHeight = tabViewHeight;
    if (self.isViewLoaded) {
        [self setTopOffset:_topOffSet];
    }
}

- (void) setTopView:(UIView *)topView
{
    if (_topView != topView) {
        [_topView removeFromSuperview];
        if (topView) {
            [self.view addSubview:topView];
        }
        _topView = topView;
        _topViewHeight = CGRectGetHeight(_topView.frame);
    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch* touch =[touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    CGFloat offset = currentPoint.y - previousPoint.y;
    
    [self moveStepOffset:offset];
    
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    //
    _animating = NO;
    _firstLoadFrame = YES;
    //
    if (_tabViewHeight <=0.1) {
        _tabViewHeight = 44;
    }
    //
    _tapTabbarAnimating = NO;
    [self dz_addChildViewController:self.pageViewController];
    [self.view addSubview:self.tabView];
    
    NSMutableArray* itemsArray = [NSMutableArray new];
    for (UIViewController* vc in _viewControllers) {
        Class contentClass = _tabItemContentViewClass;
        if (!contentClass) {
            contentClass = [DZTabItemContentView class];
        }
        DZTabViewItem* item = [[DZTabViewItem alloc] initWithContentClass:contentClass];
        item.textLabel.text = vc.swipeTitle;
        item.imageView.image = vc.swipeImage;
        item.imageView.highlightedImage = vc.swipeSelectedImage;
        item.contentView.viewController = vc;
        [itemsArray addObject:item];
        vc.swipeTabItem = item;
    }
    [self addObserverForChildScrollView];
    [self.tabView setItems:itemsArray];
    [self.pageViewController setViewControllers:@[_viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [[(UIViewController*)_viewControllers.firstObject swipeTabItem] setSelected:YES];
}

- (void) setTopOffset:(CGFloat)offset
{
    _topOffSet = offset;
    CGFloat contentWidth =  CGRectGetWidth(self.view.bounds);
    CGFloat contentHeight = CGRectGetHeight(self.view.bounds);
    
    _pageViewController.view.frame = CGRectMake( 0, CGRectGetMaxY(_tabView.frame), contentWidth , contentHeight - CGRectGetMaxY(_tabView.frame));
    _topView.frame = CGRectMake(0, offset, contentWidth , _topViewHeight);
    _tabView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), contentWidth, _tabViewHeight);
    _pageViewController.view.frame = CGRectMake( 0, CGRectGetMaxY(_tabView.frame), contentWidth , contentHeight - CGRectGetMaxY(_tabView.frame));
    [_pageViewController.view setNeedsLayout];
}

- (void) moveStepOffset:(CGFloat)offset
{
    CGFloat currentOffset = CGRectGetMinY(_topView.frame);
    CGFloat aimOffset = offset + currentOffset;
    if (aimOffset+ _topViewHeight - MUTopBannerOffset < 0) {
        aimOffset= -_topViewHeight + MUTopBannerOffset;
    }
    if (aimOffset > 0) {
        aimOffset = 0;
    }
    [self setTopOffset:aimOffset];
}
-(void)syncScrollView
{
    for (UIView* view in _pageViewController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView* pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
        }
    }
    _pageViewController.view.backgroundColor= [UIColor redColor];
}

#pragma mark 基础的布局
- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (_firstLoadFrame) {
        [self setTopOffset:0];
        _firstLoadFrame = NO;
    }
}


#pragma mark pageScrollView

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index + 1 < _viewControllers.count) {
        return _viewControllers[index +1];
    }
    return nil;
}

- (UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    if (index > 0) {
        return _viewControllers[index -1];
    }
    return nil;
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIViewController* vc = [self.pageViewController.viewControllers lastObject];
    if (!_tapTabbarAnimating) {
        CGFloat xFromCenter = self.view.frame.size.width-scrollView.contentOffset.x; //%%% positive for right swipe, negative for left
        CGFloat ratio =  xFromCenter / CGRectGetWidth(scrollView.frame);
        [self.tabView setSelectedViewOffSetRatio:ratio];
    }
}
- (void) dz_tabView:(DZTabView *)tabView didSelectedAtIndex:(NSUInteger)index
{
    UIPageViewControllerNavigationDirection direction =
    self.tabView.lastSelectedIndex > index ?
    UIPageViewControllerNavigationDirectionReverse :
    UIPageViewControllerNavigationDirectionForward;
    
    _tapTabbarAnimating = YES;
    __weak DZSwipeViewController* swipeVC = self;
    [self.pageViewController setViewControllers:@[_viewControllers[index]] direction:direction animated:YES completion:^(BOOL finished) {
        DZSwipeViewController* swipe = swipeVC;
        swipe.tapTabbarAnimating = NO;
        swipe.currentPageIndex = index;
    }];
    
    [self setTopOffset:-1000];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        _currentPageIndex = [_viewControllers indexOfObject:[self.pageViewController.viewControllers lastObject]];
        [self.tabView setSelectedIndex:_currentPageIndex];
    } else {
        
    }
}
@end
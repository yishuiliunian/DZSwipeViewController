//
//  DZTabView.h
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import <UIKit/UIKit.h>

@class DZTabView;
@class DZTabViewItem;
@protocol DZTabViewDelegate <NSObject>

- (void) dz_tabView:(DZTabView*)tabView didSelectedAtIndex:(NSUInteger)index;


@end
@interface DZTabView : UIScrollView
@property (nonatomic, strong) UIView* selectedIndicatorView;
@property (nonatomic, weak) id<DZTabViewDelegate> tabDelegate;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign, readonly) NSInteger lastSelectedIndex;
- (DZTabViewItem*) itemAtIndex:(NSInteger)index;
- (instancetype) initWithItems:(NSArray*)items;
- (void) setItems:(NSArray*)items;
- (void) setSelectedViewOffSetRatio:(CGFloat)ratio;
- (void) setSelectedIndex:(NSInteger)index;
@end

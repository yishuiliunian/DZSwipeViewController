//
//  DZTabView.h
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import <UIKit/UIKit.h>

@class DZTabView;
@protocol DZTabViewDelegate <NSObject>

- (void) dz_tabView:(DZTabView*)tabView didSelectedAtIndex:(NSUInteger)index;

@end
@interface DZTabView : UIView
@property (nonatomic, strong, readonly) UIImageView* selectedImageView;
@property (nonatomic, weak) id<DZTabViewDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger lastSelectedIndex;
- (instancetype) initWithItems:(NSArray*)items;
- (void) setItems:(NSArray*)items;
- (void) setSelectedViewOffSetRatio:(CGFloat)ratio;
- (void) setSelectedIndex:(NSInteger)index;
@end

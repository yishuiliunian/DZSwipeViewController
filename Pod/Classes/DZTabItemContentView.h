//
//  DZTabItemContentView.h
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZTabItemContentView : UIView {
    UILabel* _textLabel;
    UIImageView* _imageView;
}
@property (nonatomic, strong, readonly) UILabel* textLabel;
@property (nonatomic, strong, readonly) UIImageView* imageView;
@property (nonatomic, weak) UIViewController* viewController;
@property (nonatomic, assign)BOOL selected;
- (void) swipeInfoChangedValue:(NSObject*)value forKey:(NSString*)key;
@end

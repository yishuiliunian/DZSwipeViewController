//
//  DZTabItemContentView.h
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZTabItemContentView : UIView
@property (nonatomic, strong, readonly) UILabel* textLabel;
@property (nonatomic, strong, readonly) UIImageView* imageView;
@property (nonatomic, assign)BOOL selected;
@end

//
//  DZTabItemContentView.m
//  DZSwipeViewController
//
//  Created by stonedong on 15/3/28.
//  Copyright (c) 2015年 stonedong. All rights reserved.
//

#import "DZTabItemContentView.h"
#import "UIViewController+DZSwipeViewController.h"
@implementation DZTabItemContentView
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _textLabel = [UILabel new];
    [self addSubview:_textLabel];
    
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    
    _textLabel.adjustsFontSizeToFitWidth = YES;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat center = CGRectGetWidth(self.frame)/2;
    CGFloat imageWidth = 15;
    _imageView.frame = CGRectMake(center - imageWidth -5, (CGRectGetHeight(self.bounds) - imageWidth )/2, imageWidth, imageWidth);
    _textLabel.frame = CGRectMake(center, 0, center, CGRectGetHeight(self.bounds));
}

- (void) setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) {
        _textLabel.textColor = [UIColor blueColor];
        if (self.viewController.swipeSelectedImage) {
            _imageView.image = self.viewController.swipeSelectedImage;
        }
    } else {
        _textLabel.textColor = [UIColor blackColor];
        _imageView.image = self.viewController.swipeImage;
    }
}

- (void) swipeInfoChangedValue:(NSObject*)value forKey:(NSString*)key
{
    
}
@end


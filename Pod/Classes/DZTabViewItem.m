//
//  DZTabViewItem.m
//  Pods
//
//  Created by stonedong on 15/3/5.
//
//

#import "DZTabViewItem.h"
#import "DZTabViewItem_Private.h"

@implementation DZTabViewItem
@synthesize selected = _selected;

- (instancetype) initWithContentClass:(Class)cla
{
    self = [super init];
    if (!self) {
        return self;
    }
    [self setContentViewClass:cla];
    return self;
}
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    return self;
}

- (void) setContentViewClass:(Class)contentViewClass
{
    if (_contentViewClass != contentViewClass) {
        _contentViewClass = contentViewClass;
        if (_contentView) {
            [_contentView removeFromSuperview];
        }
        if (_contentViewClass) {
            _contentView = [_contentViewClass new];
            [self addSubview:_contentView];
            [self setNeedsLayout];
        }
    }
}

- (UILabel*) textLabel
{
    if ([_contentView isKindOfClass:[DZTabItemContentView class]]) {
        return [(DZTabItemContentView*)_contentView textLabel];
    }
    return nil;
}

//- (UIImageView*) imageView
//{
//    if ([_contentView isKindOfClass:[DZTabItemContentView class]]) {
//        return [(DZTabItemContentView*)_contentView imageView];
//    }
//    return nil;
//}

- (BOOL) isSelected
{
    return _selected;
}

- (void) setSelected:(BOOL)selected
{
    _selected = selected;
    [self.contentView setSelected:selected];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

@end
//
//  CTDynamicImageEditBar.m
//  StoreHouseDemo
//
//  Created by casa on 7/8/15.
//  Copyright (c) 2015 casa. All rights reserved.
//

#import "CTDynamicImageEditBar.h"
#import "UIView+LayoutMethods.h"

@interface CTDynamicImageEditBar ()

@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIView *seperateLine;

@end

@implementation CTDynamicImageEditBar

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self addSubview:self.editButton];
        [self addSubview:self.deleteButton];
        [self addSubview:self.seperateLine];
    }
    return self;
}

- (void)layoutSubviews
{
    self.editButton.size = CGSizeMake(self.height - 6, self.height - 6);
    [self.editButton leftInContainer:3 shouldResize:NO];
    [self.editButton centerYEqualToView:self];
    
    [self.deleteButton sizeEqualToView:self.editButton];
    [self.deleteButton rightInContainer:3 shouldResize:NO];
    [self.deleteButton centerYEqualToView:self];
    
    self.seperateLine.size = CGSizeMake(1, self.height - 6);
    [self.seperateLine centerYEqualToView:self];
    [self.seperateLine centerXEqualToView:self];
}

#pragma mark - public methods
- (void)showInView:(UIView *)view frame:(CGRect)frame
{
    [view addSubview:self];
    
    CGFloat buttonheight = 40;
    CGFloat selfWidth = (2 * buttonheight) + 1 + 3*4;
    CGFloat selfHeight = buttonheight + 6;
    
    CGRect initFrame;
    if (frame.origin.y - selfHeight < 10) {
        initFrame = CGRectMake(frame.origin.x + frame.size.width / 2.0f, (frame.origin.y + frame.size.height) / 2.0f, 0, 0);
    } else {
        initFrame = CGRectMake(frame.origin.x + frame.size.width / 2.0f, frame.origin.y - selfHeight / 2.0f, 0, 0);
    }
    self.frame = initFrame;
    
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:1.0 options:0 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGRect frame = CGRectMake(initFrame.origin.x - selfWidth / 2.0f, initFrame.origin.y - selfHeight / 2.0f, selfWidth, selfHeight);
        strongSelf.frame = frame;
    } completion:nil];
}

- (void)hide
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.frame = CGRectMake(strongSelf.centerX, strongSelf.centerY, 0, 0);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (finished) {
            [strongSelf removeFromSuperview];
        }
    }];
}

#pragma mark - event response
- (void)didTappedEditButton:(UIButton *)editButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageEditBar:didTappedEditButton:)]) {
        [self.delegate imageEditBar:self didTappedEditButton:editButton];
    }
}

- (void)didTappedDeleteButton:(UIButton *)deleteButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageEditBar:didTappedDeleteButton:)]) {
        [self.delegate imageEditBar:self didTappedDeleteButton:deleteButton];
    }
}


#pragma mark - getters and setters
- (UIButton *)editButton
{
    if (_editButton == nil) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton setTitle:@"edit" forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(didTappedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"del" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(didTappedDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIView *)seperateLine
{
    if (_seperateLine == nil) {
        _seperateLine = [[UIView alloc] init];
        _seperateLine.backgroundColor = [UIColor whiteColor];
    }
    return _seperateLine;
}

@end

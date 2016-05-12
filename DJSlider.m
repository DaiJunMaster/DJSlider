//
//  DJSlider.m
//  DJSlider
//
//  Created by 代俊 on 16/5/10.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import "DJSlider.h"

@interface DJSlider ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *valueView;
@property (nonatomic, strong) UIImageView *sliderView;

@end

@implementation DJSlider

#pragma mark -- <init>

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark -- <getter>

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds) / 3.0 * 2.0)];
        _backgroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _backgroundView.layer.borderWidth = 1.f;
    }
    return _backgroundView;
}

- (UIView *)valueView {
    if (!_valueView) {
        _valueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGRectGetMaxY(self.bounds) * 2.0 / 3.0)];
//        _valueView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        _valueView.layer.borderWidth = 1.f;
    }
    return _valueView;
}

- (UIImageView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxY(self.bounds), CGRectGetMaxY(self.bounds))];
        self.sliderView.center = CGPointMake(0, CGRectGetMaxY(self.bounds) / 2.0);
        _sliderView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _sliderView.layer.borderWidth = 1.f;
        _sliderView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
        pan.delegate = self;
        [_sliderView addGestureRecognizer:pan];
    }
    return _sliderView;
}

#pragma mark -- <setter>

- (void)setValue:(CGFloat)value {
    if (_value != value) {
        _value = value;
        [self setValue:value animated:NO];
    }
}

- (void)setSliderImg:(UIImage *)sliderImg {
    _sliderImg = sliderImg;
    _sliderView.image = _sliderImg;
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    _sliderView.backgroundColor = _sliderColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.valueView.backgroundColor = tintColor;
}

- (void)setSliderBackgroundColor:(UIColor *)sliderBackgroundColor {
    _sliderBackgroundColor = sliderBackgroundColor;
    _backgroundView.backgroundColor = _sliderBackgroundColor;
}

#pragma mark -- <methods>
- (void)initUI {
    [self addSubview:self.backgroundView];
    [self addSubview:self.valueView];
    [self addSubview:self.sliderView];
    self.tintColor = [UIColor colorWithRed:0 green:242 / 255.0 blue:121 / 255.0 alpha:1];
    self.sliderColor = [UIColor whiteColor];
    self.sliderBackgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat percent = _value / (_maxValue - _minValue);

    self.backgroundView.frame = CGRectMake(CGRectGetMaxY(self.bounds) / 2.0, 0, CGRectGetMaxX(self.bounds) - CGRectGetMaxY(self.bounds), CGRectGetMaxY(self.bounds) * 2.0 / 3.0);
    self.backgroundView.center = CGPointMake(_backgroundView.center.x, CGRectGetMaxY(self.bounds) / 2.0);
    self.backgroundView.layer.cornerRadius = CGRectGetMaxY(_backgroundView.bounds) / 2.0;

    self.valueView.frame = CGRectMake(CGRectGetMaxY(self.bounds) / 2, 0, CGRectGetMaxX(_backgroundView.bounds) * percent, CGRectGetMaxY(self.bounds) * 2.0 / 3.0);
    self.valueView.center = CGPointMake(_valueView.center.x, CGRectGetMaxY(self.bounds) / 2.0);
    self.valueView.layer.cornerRadius = CGRectGetMaxY(_valueView.bounds) / 2.0;
    
    self.sliderView.frame = CGRectMake(0, 0, CGRectGetMaxY(self.bounds), CGRectGetMaxY(self.bounds));
    _sliderView.center = CGPointMake(CGRectGetMaxX(_backgroundView.bounds) * percent + CGRectGetMaxY(self.bounds) / 2.0, _sliderView.center.y);
    self.sliderView.layer.cornerRadius = CGRectGetMaxY(_sliderView.bounds) / 2.0;
    self.sliderView.clipsToBounds = YES;
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
    if (value < _minValue || value > _maxValue) {
        return;
    }
    _value = value;
    if (self.block) {
        self.block(_value);
    }
    CGFloat percent = value / (_maxValue - _minValue);
    if (animated) {
        [UIView animateWithDuration:0.8 * percent animations:^{
            _sliderView.center = CGPointMake(CGRectGetMaxX(_backgroundView.bounds) * percent, _sliderView.center.y);
            _valueView.frame = CGRectMake(CGRectGetMaxY(self.bounds) / 2.0, _valueView.frame.origin.y, CGRectGetMaxX(self.bounds) * percent, _valueView.frame.size.height);
        }];
    }
    else {
        [self layoutSubviews];
    }
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self];
    CGFloat value = point.x / CGRectGetMaxX(self.bounds) * (_maxValue - _minValue) + _value;
    if (value > _maxValue) {
        self.value = _maxValue;
    }
    else if (value < _minValue) {
        self.value = _minValue;
    }
    else {
        self.value = value;
    }
    [pan setTranslation:CGPointZero inView:self];
    
}

@end

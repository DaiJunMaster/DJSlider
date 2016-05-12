//
//  DJSlider.h
//  DJSlider
//
//  Created by 代俊 on 16/5/10.
//  Copyright © 2016年 代俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DJSliderValueChangedBlock)(CGFloat value);

@interface DJSlider : UIControl
/**
 *  最大值
 */
@property (nonatomic, assign) CGFloat maxValue;
/**
 *  最小值
 */
@property (nonatomic, assign) CGFloat minValue;
/**
 *  value
 */
@property (nonatomic, assign) CGFloat value;
/**
 *  滑条颜色
 */
@property (nonatomic, strong) UIColor *sliderBackgroundColor;
/**
 *  滑块图片
 */
@property (nonatomic, strong) UIImage *sliderImg;
/**
 *  滑块颜色
 */
@property (nonatomic, strong) UIColor *sliderColor;
/**
 *  划过的颜色
 */
@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, copy) DJSliderValueChangedBlock block;

- (void)setValue:(CGFloat)value animated:(BOOL)animated;

@end

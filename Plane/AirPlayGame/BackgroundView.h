//
//  BackgroundView.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView:UIView

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image;

//更新背景图片位置
-(void)changeBGWithFrame1:(CGRect)frame1 rame2:(CGRect)frame2;

@end

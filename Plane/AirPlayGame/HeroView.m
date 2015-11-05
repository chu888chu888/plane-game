//
//  HeroView.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "HeroView.h"

@implementation HeroView

//参数：飞行的图像数组
-(id)initWithImages:(NSArray *)images
{
    self = [super initWithImage:images[0]];
    
    if (self) {
        //设置序列帧动画
        [self setAnimationImages:images];
        //设置播放的时长
        [self setAnimationDuration:1.0];
        //启动动画
        [self startAnimating];
    }
    
    return self;
}

@end

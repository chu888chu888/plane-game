//
//  Bullet.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Bullet:NSObject

//方法1：给定英雄的位置，计算第几颗子弹，算出该子弹的位置
//方法2：由英雄调用（循环三次），直接给定子弹位置，和是否增强(选择使用)
+(id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced;

//位置
@property (assign, nonatomic)CGPoint position;

//伤害值
@property (assign, nonatomic)NSInteger damage;

//是否是增强子弹（主要用于界面显示时使用哪一张图片）
@property (assign, nonatomic)BOOL isEnhanced;

@end

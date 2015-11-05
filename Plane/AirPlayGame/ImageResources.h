//
//  ImageResources.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageResources:NSObject

//背景图片
@property (strong, nonatomic)UIImage *bgImage;

//英雄飞行图片数组
@property (strong, nonatomic)NSArray *heroFlyImages;

//英雄爆炸图片数组
@property (strong, nonatomic)NSArray *heroBlowupImages;

//普通子弹
@property (strong, nonatomic)UIImage *bulletNormalImage;
//加强子弹
@property (strong, nonatomic)UIImage *bulletEnhancedImage;

#pragma mark - 敌机图片
//小飞机飞行图像
@property (strong, nonatomic)UIImage *enemySmallImage;
//小飞机爆炸数组
@property (strong, nonatomic)NSArray *enemySmallBlowupImages;
//中飞机飞行图像
@property (strong, nonatomic)UIImage *enemyMiddleImage;
//中飞机爆炸数组
@property (strong, nonatomic)NSArray *enemyMiddleBlowupImages;
//中飞机挨揍图像
@property (strong, nonatomic)UIImage *enemyMiddleHitImage;
//大飞机飞行数组
@property (strong, nonatomic)NSArray *enemyBigImages;
//大飞机爆炸数组
@property (strong, nonatomic)NSArray *enemyBigBlowupImages;
//大飞机挨揍图像
@property (strong, nonatomic)UIImage *enemyBigHitImage;

@end

//
//  GameModel.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Hero.h"
#import "Enemy.h"

@interface GameModel:NSObject

#pragma mark - 工厂方法
+(id)gameModelWithArea:(CGRect)gameAera heroSize:(CGSize)heroSize;

#pragma mark - 游戏区域
@property (assign, nonatomic)CGRect gameAera;

@property (assign, nonatomic)NSInteger score;

#pragma mark - 背景图片的位置及方法
#pragma mark 背景图片的位置
@property (assign, nonatomic)CGRect bgFrame1;
@property (assign, nonatomic)CGRect bgFrame2;

#pragma mark - 成员方法
#pragma mark 背景图片向下移动
-(void)bgMoveDown;


#pragma mark - 英雄的属性及方法
#pragma mark 英雄的属性
@property (strong, nonatomic)Hero *hero;
#pragma mark 英雄的方法

#pragma mark - 创建敌机
//敌机跟子弹是有区别的，子弹时一次发射三颗，而敌机每次只有一个
//因此定义一个方法，返回敌机的模型即可
-(Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size;

@end

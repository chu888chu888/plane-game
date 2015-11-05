//
//  GameModel.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

+(id)gameModelWithArea:(CGRect)gameAera heroSize:(CGSize)heroSize
{
    GameModel *m = [[GameModel alloc]init];
    
    m.gameAera = gameAera;
    
    //背景图片边框
    m.bgFrame1 = gameAera;
    m.bgFrame2 = CGRectOffset(gameAera, 0, -gameAera.size.height);
    
    //实例化英雄，英雄是独一无二的，可以针对该对象，对工厂方法进行扩展
    m.hero = [Hero heroWithSize:heroSize gameArea:gameAera];
    
    m.score = 0;
    
    return m;
}

#pragma mark - 背景图片向下移动
-(void)bgMoveDown
{
    //两张背景统一向下移动1点
    self.bgFrame1 = CGRectOffset(self.bgFrame1, 0, 1);
    self.bgFrame2 = CGRectOffset(self.bgFrame2, 0, 1);
    
    //如果背景图片已经完全从游戏区域下方移出，将其调整至游戏区域上方
    CGRect topFrame = CGRectOffset(self.gameAera, 0, -self.gameAera.size.height);
    
    if (self.bgFrame1.origin.y >= self.gameAera.size.height) {
        self.bgFrame1 = topFrame;
    }
    if (self.bgFrame2.origin.y >= self.gameAera.size.height) {
        self.bgFrame2 = topFrame;
    }
}

#pragma mark - 创建敌机
//敌机跟子弹是有区别的，子弹时一次发射三颗，而敌机每次只有一个
//因此定义一个方法，返回敌机的模型即可
-(Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size
{
    return [Enemy enemyWithType:type size:size gameArea:self.gameAera];
    
}

@end

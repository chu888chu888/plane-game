//
//  Enemy.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

+(id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea
{
    Enemy *e = [[Enemy alloc]init];
    
    e.type = type;
    
    //计算敌机的位置
    CGFloat x = arc4random_uniform(gameArea.size.width - size.width) + size.width / 2.0;
    CGFloat y = -size.height / 2.0;
    e.position = CGPointMake(x, y);
    
    //根据敌机类型，设置其他属性
    /*
     得分如果时1000的倍数，可以直接用个位数表示，在显示得分时，末尾加“000”即可，可以提高极微小的效率
     提示：设置速度时，不要设置为1，因为背景速度为1，否则会产生敌机贴在背景上不动的效果
     */
    switch (type) {
        case kEnemySmall:
            e.hp = 1;
            e.speed = arc4random_uniform(4) + 2;
            e.score = 1;
            break;
            
        case kEnemyMiddle:
            e.hp = 10;
            e.speed = arc4random_uniform(3) + 2;
            e.score = 10;
            break;
            
        case kEnemyBig:
            e.hp = 50;
            e.speed = arc4random_uniform(2) + 2;
            e.score = 30;
            break;
            
        default:
            break;
    }
    
    e.blowupFrames = 0;
    e.toBlowup = NO;
    
    return e;
}

@end

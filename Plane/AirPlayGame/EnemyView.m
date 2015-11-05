//
//  EnemyView.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "EnemyView.h"

@implementation EnemyView


//参数enemy应该在视图控制器中完成实例化，在此辅助图像视图的外观建立
-(id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes
{
    self = [super init];
    
    if (self) {
        self.enemy = enemy;
        
        //根据敌机类型设置敌机的相关图像
        switch (self.enemy.type) {
            case kEnemySmall:
                self.image = imageRes.enemySmallImage;
                self.blowupImages = imageRes.enemySmallBlowupImages;
                break;
            case kEnemyMiddle:
                self.image = imageRes.enemyMiddleImage;
                self.blowupImages = imageRes.enemyMiddleBlowupImages;
                self.hitImage = imageRes.enemyMiddleHitImage;
                break;
            case kEnemyBig:
                self.image = imageRes.enemyBigImages[0];
                //因为打飞机有多张图片，需要播放序列帧动画
                self.animationImages = imageRes.enemyBigImages;
                self.animationDuration = 0.5f;
                //播放序列帧动画
                [self startAnimating];
                
                self.blowupImages = imageRes.enemyBigBlowupImages;
                self.hitImage = imageRes.enemyBigHitImage;
                break;
                
            default:
                break;
        }
        
        //设定图像视图的frame和center
        [self setFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
        [self setCenter:enemy.position];
        
    }
    
    return self;
}

@end

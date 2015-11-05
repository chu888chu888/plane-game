//
//  Hero.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "Hero.h"
#import "Bullet.h"

//每次发射子弹的数量
#define kFireCount 3

@implementation Hero

+(id)heroWithSize:(CGSize)size gameArea:(CGRect)gameAera
{
    Hero *h = [[Hero alloc]init];
    
    //计算位置
    CGFloat x = gameAera.size.width / 2;
    //y方向预留了半个机身
    CGFloat y = gameAera.size.height - size.height;
    h.position = CGPointMake(x, y);
    h.size = size;
    
    h.bombCount = 0;
    h.enhancedTime = 0;
    h.isEnhancedBullet = NO;
    
    //实例化子弹集合,因为子弹发射的频率非常高，所以保存子弹的集合不适合用懒加载的方式
    h.bulletSet = [NSMutableSet set];
    
    return h;
}

#pragma mark 碰撞检测使用的frame，getter方法
-(CGRect)collisionFrame
{
    CGFloat x = self.position.x - self.size.width / 4.0;
    CGFloat y = self.position.y - self.size.height / 2.0;
    CGFloat w = self.size.width / 2.0;
    CGFloat h = self.size.height;
    
    return CGRectMake(x, y, w, h);
}

#pragma mark - 成员方法
#pragma mark 发射子弹
//发射子弹
//发射子弹之前，需要指定bulletNormalSize和bulletEnhancedSize
-(void)fire
{
    //循环发射子弹，意味创建kFireCount个子弹的实例
    //需要根据子弹是否加强，计算当前使用子弹的大小
    //self.isEnhancedBullet = YES;
    
    CGSize bulletSize = self.bulletNormalSize;
    if (self.isEnhancedBullet) {
        bulletSize = self.bulletEnhancedSize;
    }
    
    //计算第一颗子弹的坐标
    CGFloat y = self.position.y - self.size.height / 2 - bulletSize.height / 2;
    CGFloat x = self.position.x;
    for (NSInteger i = 0; i < kFireCount; i++) {
        CGPoint p = CGPointMake(x, y - i * bulletSize.height * 2);
        
        Bullet *b = [Bullet bulletWithPosition:p isEnhanced:self.isEnhancedBullet];
        
        [self.bulletSet addObject:b];
    }
}

@end

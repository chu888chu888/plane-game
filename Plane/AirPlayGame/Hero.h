//
//  Hero.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Hero:NSObject

//工厂方法，根据英雄的size和gameAera计算英雄出现的位置
+(id)heroWithSize:(CGSize)size gameArea:(CGRect)gameAera;

-(void)fire;

//中心点位置
@property (assign, nonatomic)CGPoint position;

//飞机的大小
@property (assign, nonatomic)CGSize size;

//英雄碰撞检测frame
@property (assign, nonatomic, readonly)CGRect collisionFrame;

//炸弹的数量
@property (assign, nonatomic)NSInteger bombCount;

//子弹是否增强
@property (assign, nonatomic)BOOL isEnhancedBullet;

//子弹增强时间
@property (assign, nonatomic)NSInteger enhancedTime;

#pragma mark 子弹辅助参数
@property (assign, nonatomic)CGSize bulletNormalSize;
@property (assign, nonatomic)CGSize bulletEnhancedSize;

/*集合相对于数组，是无序的，所以set的维护开销要比array小，
 通常在处理无序对象时使用，
 使用集合时，最常用的做法就是遍历集合中所有的元素*/
@property (strong, nonatomic)NSMutableSet *bulletSet;

@end

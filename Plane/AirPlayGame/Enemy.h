//
//  Enemy.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    kEnemySmall = 0,
    kEnemyMiddle,
    kEnemyBig
}EnemyType;

@interface Enemy:NSObject

#pragma mark - 工厂方法
//根据游戏时钟触发，出来连续增加到游戏中，例如：每秒增加3架敌机
//敌机的类型不同，大小不同。默认出现的位置都在游戏的正上方随机水平位置，等待进入屏幕
//工厂方法中，需要传入不同类型的敌机尺寸
//通过整理，需要传入：敌机类型，敌机尺寸，游戏区域
+(id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea;

#pragma mark - 敌机属性
//类型（小，中，大）
@property (assign, nonatomic)EnemyType type;

//位置
@property (assign, nonatomic)CGPoint position;

//生命值（不是所有的敌机都能一枪干掉）
@property (assign, nonatomic)NSInteger hp;

//速度
@property (assign, nonatomic)NSInteger speed;

//得分
@property (assign, nonatomic)NSInteger score;

//飞机爆炸标识，如果为真，标识飞机要爆炸，供碰撞检测使用
@property (assign, nonatomic)BOOL toBlowup;
//爆炸动画已经播放的帧数
@property (assign, nonatomic)NSInteger blowupFrames;

@end

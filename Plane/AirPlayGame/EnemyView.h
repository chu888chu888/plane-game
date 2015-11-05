//
//  EnemyView.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enemy.h"
#import "ImageResources.h"

@interface EnemyView:UIImageView

//为了提高效率，在视图直接记录相关的图像
@property (strong, nonatomic)NSArray *blowupImages;
@property (strong, nonatomic)UIImage *hitImage;

//敌机模型，便于后续处理
@property (strong, nonatomic)Enemy *enemy;

//1.敌机的大小不一致
//2.敌机有飞行的图像，或者数组
//3.敌机有挨揍的图像
//4.敌机有爆炸的图像，或者数组
//综上所述：实例化方法传入Enemy对象，和ImageRes对象，可以简化参数传递
-(id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes;

@end

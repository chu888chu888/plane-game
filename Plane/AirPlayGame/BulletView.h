//
//  BulletView.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bullet.h"

@interface BulletView:UIImageView

//记录该颗子弹的模型对象，方便后续的子弹打飞机等逻辑处理
@property (strong, nonatomic)Bullet *bullet;

-(id)initWithImage:(UIImage *)image  bullet:(Bullet *)bullet;

@end

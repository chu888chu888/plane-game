//
//  BulletView.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "BulletView.h"

@implementation BulletView

-(id)initWithImage:(UIImage *)image  bullet:(Bullet *)bullet
{
    self = [super initWithImage:image];
    
    if(self){
        self.bullet = bullet;
    }
    
    return self;
}

@end

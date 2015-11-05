//
//  Bullet.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

#define kDamageNormal 1
#define kDamageEnhanced 2

+(id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced
{
    Bullet *b = [[Bullet alloc]init];
    
    b.position = position;
    b.isEnhanced = isEnhanced;
    
    b.damage = isEnhanced ? kDamageEnhanced : kDamageNormal;
    
    return b;
}

@end

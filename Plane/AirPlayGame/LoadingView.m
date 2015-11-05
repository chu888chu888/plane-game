//
//  LoadingView.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //1.实例化四张图像
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
        for (NSInteger i = 0; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"images.bundle/loading%ld.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [arrayM addObject:image];
        }
        
        //2.建立UIImageView
        UIImageView *imageView = [[UIImageView alloc]initWithImage:arrayM[0]];
        
        //3.将UIImageView放置在屏幕中心位置
        [imageView setCenter:self.center];
        [self addSubview:imageView];
        
        //4.播放序列帧动画
        //(1)设置序列帧动画数组
        [imageView setAnimationImages:arrayM];
        
        //(2)设置序列帧动画时长
        [imageView setAnimationDuration:1.0f];
        
        //(3)开始动画
        [imageView startAnimating];
    }
    
    return self;
}

@end

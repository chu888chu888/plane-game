//
//  BackgroundView.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView()

@property (strong, nonatomic)UIImageView *bgView1;
@property (strong, nonatomic)UIImageView *bgView2;

@end

@implementation BackgroundView

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //实例化图片
        UIImageView *bgView1 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bgView1];
        self.bgView1 = bgView1;
        
        UIImageView *bgView2 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bgView2];
        self.bgView2 = bgView2;
    }
    
    return self;
}

//更新背景图片位置
-(void)changeBGWithFrame1:(CGRect)frame1 rame2:(CGRect)frame2
{
    [self.bgView1 setFrame:frame1];
    [self.bgView2 setFrame:frame2];
}

@end

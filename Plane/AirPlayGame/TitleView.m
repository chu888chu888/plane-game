//
//  TitleView.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //1.显示背景图片
        UIImage *bgImage = [UIImage imageNamed:@"images.bundle/background_2.png"];
        UIImageView *bgView = [[UIImageView alloc]initWithImage:bgImage];
        [bgView setFrame:self.frame];
        
        [self addSubview:bgView];
        
        //2.显示标题
        UIImage *titleImage = [UIImage imageNamed:@"images.bundle/BurstAircraftLogo.png"];
        UIImageView *titleView = [[UIImageView alloc]initWithImage:titleImage];
        
        [titleView setCenter:self.center];
        [self addSubview:titleView];
        
    }
    
    return self;
}

@end

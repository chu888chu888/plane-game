//
//  ImageResources.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "ImageResources.h"

@implementation ImageResources

#pragma mark - 私有方法
#pragma mark 从指定bundle中加载图像
-(UIImage *)loadImageWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName
{
    //从images.bundle中加载指定文件名的图像
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
    
}
#pragma mark 从指定bundle中加载序列帧图像数组
//参数：format就是文件名的格式字符串
-(NSArray *)loadImagesWithBundle:(NSBundle *)bundle format:(NSString *)format count:(NSInteger)count
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 1; i <= count; i++) {
        NSString *imageName = [NSString stringWithFormat:format, i];
        
        UIImage *image = [self loadImageWithBundle:bundle imageName:imageName];
        
        [arrayM addObject:image];
    }
    
    return arrayM;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        //加载图片资源，
        //在游戏开发中，对于游戏视图中需要使用到图像资源，最好不要使用缓存
        //imageNamed方法有缓存，系统负责管理
        //imageWithContentsOfFile方法无缓存
        
        //1.实例化bundle
        //1)取出images.bundle的bundle路径
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"images.bundle"];
        
        //2)建立images.bundle的包
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        //3)加载背景图片
        self.bgImage = [self loadImageWithBundle:bundle imageName:@"background_2"];
        
        //4)加载英雄飞行图片
        self.heroFlyImages = [self loadImagesWithBundle:bundle format:@"hero_fly_%ld" count:2];
        
        self.heroBlowupImages = [self loadImagesWithBundle:bundle format:@"hero_blowup_%ld" count:4];
        
        //5)子弹图片
        self.bulletNormalImage = [self loadImageWithBundle:bundle imageName:@"bullet1"];
        self.bulletEnhancedImage = [self loadImageWithBundle:bundle imageName:@"bullet2"];
        
        //6)小飞机
        self.enemySmallImage = [self loadImageWithBundle:bundle imageName:@"enemy1_fly_1"];
        self.enemySmallBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy1_blowup_%ld" count:4];
        
        //7)中飞机
        self.enemyMiddleImage = [self loadImageWithBundle:bundle imageName:@"enemy3_fly_1"];
        self.enemyMiddleHitImage = [self loadImageWithBundle:bundle imageName:@"enemy3_hit_1"];
        self.enemyMiddleBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy3_blowup_%ld" count:4];
        
        //8)大飞机
        self.enemyBigImages = [self loadImagesWithBundle:bundle format:@"enemy2_fly_%ld" count:2];
        self.enemyBigHitImage = [self loadImageWithBundle:bundle imageName:@"enemy2_hit_1"];
        self.enemyBigBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy2_blowup_%ld" count:7];
        
    }
    
    return self;
}

@end

//
//  SoundTool.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "SoundTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundTool()

//音乐播放器
@property (strong, nonatomic)AVAudioPlayer *musicPlayer;

//使用数据字典来维护音效ID
@property (strong, nonatomic)NSDictionary *soundDict;

@end

@implementation SoundTool

#pragma mark - 私有方法
#pragma mark 加载音效
-(SystemSoundID)loadSoundIdWithBundleName:(NSBundle*)bundle name:(NSString *)name
{
    SystemSoundID soundId;
    
    NSString *path = [bundle pathForResource:name ofType:@"mp3" ];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //提示：不需要硬记代码，可以直接输入url，然后让xcode帮我们修复代码，完成bridge的类型转换
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    
    //NSLog(@"soundId %d", soundId);
    
    return soundId;
}

#pragma mark 加载声音文件到数据字典
-(NSDictionary *)loadSoundsWithBundle:(NSBundle *)bundle
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    //数组中存放所有声音的文件名
    NSArray *array = @[@"bullet", @"enemy1_down", @"enemy2_down", @"enemy2_out", @"enemy3_down", @"game_over"];
    
    //1.遍历数据，2.创建声音ID，3.添加到字典
    for(NSString *name in array){
        SystemSoundID soundId = [self loadSoundIdWithBundleName:bundle name:name];
        
        //使用文件名作为键值添加到字典
        [dictM setObject:@(soundId) forKey:name];
    }
    
    return dictM;
}

#pragma mark - 实例化方法
-(id)init
{
    self = [super init];
    
    if (self) {
        //实例化音乐播放器，作为背景音乐
        /*
         参数：
         url：音乐文件的url
         error：错误
         */
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath] stringByAppendingPathComponent:@"music.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *path = [bundle pathForResource:@"game_music" ofType:@"mp3" ];
        NSURL *url = [NSURL fileURLWithPath:path];
        self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        
        //设置音乐播放器属性
        //1）设置循环播放
        [self.musicPlayer setNumberOfLoops:-1];
        
        //2)准备播放，将音乐加载到系统缓存，随时准备播放
        [self.musicPlayer prepareToPlay];
        
        //音效
        self.soundDict = [self loadSoundsWithBundle:bundle];

        //NSLog(@"%@", self.soundDict);
    }
    
    return self;
}

//播放背景音乐
-(void)playMusic
{
    [self.musicPlayer play];
 
}

//停止背景音乐
-(void)stopMusic
{
    [self.musicPlayer stop];
}

#pragma mark 使用文件名播放音效
-(void)playSoundByFileName:(NSString *)fileName
{
    SystemSoundID soundId = [self.soundDict[fileName] unsignedIntValue];
    
    //NSLog(@"play soundid %d", soundId);
    
    //播放音效
    AudioServicesPlaySystemSound(soundId);
    
    
}

@end

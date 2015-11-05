//
//  SoundTool.h
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

//  声音工具，预加载背景音乐（长时间播放，可以循环播放）和音效（短时间播放，点缀游戏气氛）

#import <Foundation/Foundation.h>


@interface SoundTool:NSObject

#pragma mark - 播放/停止背景音乐
-(void)playMusic;
-(void)stopMusic;

#pragma mark - 播放指定名称的音效
-(void)playSoundByFileName:(NSString *)fileName;

@end

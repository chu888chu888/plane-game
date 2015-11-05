//
//  MainViewController.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "MainViewController.h"
#import "LoadingView.h"
#import "TitleView.h"
#import "AirPlayGameViewController.h"

@interface MainViewController()

@property (weak, nonatomic)LoadingView *loadingView;
@property (weak, nonatomic)TitleView *titleView;
@property (strong, nonatomic)AirPlayGameViewController *gameController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //显示加载视图
    LoadingView *loadingView = [[LoadingView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:loadingView];
    self.loadingView = loadingView;
    
    //用后台方式，加载游戏素材资源
    //performSelectorInBackground通常用于在后台执行一些相对耗时的工作，同时不阻塞前端的主线程执行
    [self performSelectorInBackground:@selector(loadResources) withObject:nil];
}

#pragma mark - 私有方法
//用后台方式，加载游戏素材资源
-(void)loadResources
{
    //1.加载资源
    //模拟加载素材的过程，保证能够看到加载视图
    //使用线程睡眠的方法，通常在实际游戏开发过程中，不要使用此方法
    [NSThread sleepForTimeInterval:2.0];
    
    //2.实例化游戏视图控制器
    self.gameController = [[AirPlayGameViewController alloc]init];
    [self.gameController loadResources];
    
    //2.删除LoadingView
    [self.loadingView removeFromSuperview];
    
    //3.显示标题视图
    TitleView *titleView = [[TitleView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //4.在后台调用beginGame方法，当游戏素材准备就绪后，进入游戏
    [self performSelectorInBackground:@selector(beginGame) withObject:nil];
    
}

//进入游戏
-(void)beginGame
{
    //1.停留1秒删除标题视图，在进入游戏前，需要给用户一个准备时间
    //本应用的切换方式，是在微信的打飞机游戏中特有的，在实际应用当中，
    //显示出标题视图，即可停止，供用户选择“新游戏”，“继续游戏”，“帮助”，“设置”，“排行”，“分享”等功能
    //通过分享可以实现用户口碑营销，是目前游戏推广的最重要的手段之一
    [NSThread sleepForTimeInterval:1.0f];
    [self.titleView removeFromSuperview];
    
    
    
    //3.显示游戏视图控制器
    [self.view addSubview:self.gameController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

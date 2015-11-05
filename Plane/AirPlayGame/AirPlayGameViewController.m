//
//  AirPlayGameViewController.m
//  Plane
//
//  Created by dengwei on 15/6/28.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "AirPlayGameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageResources.h"
#import "SoundTool.h"
#import "BackgroundView.h"
#import "GameModel.h"
#import "HeroView.h"
#import "BulletView.h"
#import "EnemyView.h"

@interface AirPlayGameViewController()

//游戏时钟
@property (strong, nonatomic)CADisplayLink *gameTimer;

@property (strong, nonatomic)ImageResources *imagesRes;

@property (strong, nonatomic)SoundTool *soundTool;

@property (weak, nonatomic)BackgroundView *bgView;

@property (strong, nonatomic)GameModel *gameModel;

//游戏视图
@property (weak, nonatomic)UIView *gameView;

@property (weak, nonatomic)HeroView *heroView;

@property (strong, nonatomic)NSMutableSet *bulletViewSet;

//敌机集合，记录屏幕中所有飞机的视图
@property (strong, nonatomic)NSMutableSet *enemyViewSet;

@property (weak, nonatomic)UILabel *scoreLabel;

@end

static long steps;

@implementation AirPlayGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //播放背景音乐
    [self.soundTool playMusic];
    
    steps = 0;
    
    //实例化集合
    self.bulletViewSet = [NSMutableSet set];
    self.enemyViewSet = [NSMutableSet set];
    
    //此方法执行时，资源已经完成加载
    //1.实例化游戏模型
    CGSize heroSize = [self.imagesRes.heroFlyImages[0] size];
    self.gameModel = [GameModel gameModelWithArea:self.view.bounds heroSize:heroSize];
    
    [self.gameModel.hero setBulletNormalSize:self.imagesRes.bulletNormalImage.size];
    [self.gameModel.hero setBulletEnhancedSize:self.imagesRes.bulletEnhancedImage.size];
    
    //实例化游戏视图，游戏中的所有元素，均添加到游戏视图中
    UIView *gameView = [[UIView alloc]initWithFrame:self.gameModel.gameAera];
    [self.view addSubview:gameView];
    self.gameView = gameView;
    
    //添加暂停按钮和得分标签
    //1>暂停按钮
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //1)设置图像
    UIImage *image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
    [pauseButton setImage:image forState:UIControlStateNormal];
    
    //2)设置高亮图像
    UIImage *imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
    [pauseButton setImage:imageHL forState:UIControlStateHighlighted];
    
    //3)设置按钮大小
    [pauseButton setFrame:CGRectMake(20, 20, image.size.width, image.size.height)];
    
    //4)将按钮添加到视图
    [self.view addSubview:pauseButton];
    
    //5)添加按钮监听方法
    [pauseButton addTarget:self action:@selector(tapPauseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //2>得分标签
    CGFloat labelX = pauseButton.frame.origin.x + pauseButton.frame.size.width;
    CGFloat labelY = 20;
    CGFloat labelW = self.gameModel.gameAera.size.width - labelX;
    CGFloat labelH = pauseButton.frame.size.height;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    [self.view addSubview:label];
    self.scoreLabel = label;
    
    //清空背景颜色
    [label setBackgroundColor:[UIColor clearColor]];
    //设置字体
    [label setFont:[UIFont fontWithName:@"Marker Felt" size:20]];
    //NSLog(@"%@", [UIFont familyNames]);
    
    //2.实例化背景图片
    BackgroundView *bgView = [[BackgroundView alloc]initWithFrame:self.gameModel.gameAera image:self.imagesRes.bgImage];
    [self.gameView addSubview:bgView];
    self.bgView = bgView;
    
    //实例化英雄的视图
    HeroView *heroView = [[HeroView alloc]initWithImages:self.imagesRes.heroFlyImages];
    [heroView setCenter:self.gameModel.hero.position];
    [self.gameView addSubview:heroView];
    self.heroView = heroView;
    
    //2.添加到主运行循环
    [self startGameTimer];

}

#pragma mark 按钮监听方法
-(void)tapPauseButton:(UIButton *)button
{
    //NSLog(@"pause button");
    
    //tag默认是0
    //第一次点的时候，游戏是在进行时
    button.tag = !button.tag;
    
    UIImage *image = nil;
    UIImage *imageHL = nil;
    
    //如果游戏正在进行，将按钮的图像切换在开始状态，停止游戏时钟
    if (button.tag) {
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftStart.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftStartHL.png"];
        
        [self stopGameTimer];
        [self.soundTool stopMusic];
    }else{
        //如果游戏处于暂停状态，将按钮的图像切换至暂停，开始游戏时钟
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
        
        [self startGameTimer];

        [self.soundTool playMusic];
    }
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imageHL forState:UIControlStateHighlighted];
}

#pragma mark - 触摸事件
#pragma mark 触摸移动
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.取出触摸对象
    UITouch *touch = [touches anyObject];
    
    //注意：因为用户只能移动英雄，因此将触摸监控范围设置在整个屏幕上
    //2.取出当前触摸点
    CGPoint location = [touch locationInView:self.gameView];
    
    //3.取出之前触摸点
    CGPoint preLocation = [touch previousLocationInView:self.gameView];
    
    //4.计算偏移量
    CGPoint offset = CGPointMake(location.x - preLocation.x, location.y - preLocation.y);
    
    //5.更新英雄的位置
    CGPoint position = self.gameModel.hero.position;
    self.gameModel.hero.position = CGPointMake(position.x + offset.x, position.y + offset.y);
}

-(void)step
{
    steps++;
    //让游戏模型向下移动背景位置
    [self.gameModel bgMoveDown];
    //更新背景图片位置
    [self.bgView changeBGWithFrame1:self.gameModel.bgFrame1 rame2:self.gameModel.bgFrame2];
    
    //更新英雄的位置
    [self.heroView setCenter:self.gameModel.hero.position];
    
    //发射子弹
    //每秒发射三次（需要时钟步长）
    if (steps % 20 == 0) {
        //仅产生子弹的数据，并没有添加图片到界面
        [self.gameModel.hero fire];
        
        [self.soundTool playSoundByFileName:@"bullet"];
    }
    
    //每次时钟触发，都需要检查更新屏幕上所有子弹的位置
    [self checkBullets];
    
    //创建敌机
    //1)创建模型
    Enemy *enemy = nil;
    
    //在时钟方法中每秒创建3架小飞机，每隔10秒随机创建中飞机或大飞机
    if (steps % 20 == 0) {
        if (steps % (10 * 60) == 0) {
            //要随机出现大飞机或中飞机，先随机出来飞机的类型
            EnemyType type = (arc4random_uniform(2) == 0) ? kEnemyMiddle : kEnemyBig;
            
            CGSize size = self.imagesRes.enemyMiddleImage.size;
            
            if (kEnemyBig == type) {
                size = [self.imagesRes.enemyBigImages[0]size];
            }
            
            enemy = [self.gameModel createEnemyWithType:type size:size];
            
        }else{
            //小飞机
            enemy = [self.gameModel createEnemyWithType:kEnemySmall size:self.imagesRes.enemySmallImage.size];
        }
        
        //2)根据模型创建飞机视图
        EnemyView *enemyView = [[EnemyView alloc]initWithEnemy:enemy imageRes:self.imagesRes];
        
        //3)将敌机视图添加到集合及视图
        [self.enemyViewSet addObject:enemyView];
        [self.gameView addSubview:enemyView];
        
    }
    
    if (enemy.type == kEnemyBig) {
        [self.soundTool playSoundByFileName:@"enemy2_out"];
    }
    
    //调用一个方法，更新飞机位置
    [self updateEnemys];
    
    //碰撞检测
    [self collisionDetector];
}

//更新游戏得分标签
-(void)updateScoreLabel
{
    //判断游戏模型中的分数，如果等于0，清空标签内容
    if (self.gameModel.score == 0) {
        [self.scoreLabel setText:@""];
    }else{
        NSString *str = [NSString stringWithFormat:@"%ld000", self.gameModel.score];
        [self.scoreLabel setText:str];
    }
}

//碰撞检测
-(void)collisionDetector
{
    /*
     问题：爆炸动画播放太快，可以使用steps来调整爆炸动画
     */
    if (steps % 10 == 0) {
    
        //遍历飞机集合，判断toBlowup为真的飞机开始播放动画
        NSMutableSet *toRemovedSet = [NSMutableSet set];
    
        for(EnemyView *enemyView in self.enemyViewSet){
            Enemy *enemy = enemyView.enemy;
        
            if (enemy.toBlowup) {
                [enemyView setImage:enemyView.blowupImages[enemy.blowupFrames++]];
            
            }
        
            //判断动画是否播放到最后一帧
            if (enemy.blowupFrames == enemyView.blowupImages.count) {
                //需要从集合中删除飞机
                [toRemovedSet addObject:enemyView];
            }
        }
    
        for(EnemyView *enemyView in toRemovedSet){
            //修改游戏模型中的得分
            self.gameModel.score += enemyView.enemy.score;
            
            //更新游戏得分标签
            [self updateScoreLabel];
            
            [self.enemyViewSet removeObject:enemyView];
            [enemyView removeFromSuperview];
            
        }
    
        [toRemovedSet removeAllObjects];
    }
    
    //资源：子弹的集合，敌机的集合
    for (BulletView *bulletView in self.bulletViewSet) {
        Bullet *bullet = bulletView.bullet;
        
        for (EnemyView *enemyView in self.enemyViewSet) {
            Enemy *enemy = enemyView.enemy;
            
            //检查子弹和敌机的frame是否相交
            //如果敌机处于爆炸中，不做子弹和敌机的碰撞检测
            if(CGRectIntersectsRect(bulletView.frame, enemyView.frame) && !enemy.toBlowup){
                //用子弹的damage减敌机的hp
                enemy.hp -= bullet.damage;
                
                //如果敌机的hp<=0，需要销毁
                if (enemy.hp <= 0) {
                    //NSLog(@"blow up");
                    enemy.toBlowup = YES;
                    //需要播放飞机爆炸的序列帧图片
                }else{
                    //如果敌机hp>0，显示挨揍图片
                    //因为大飞机播放序列帧动画，如果仅改变image，而不停止序列帧动画，用户看不到图像
                    //如果是大飞机，需要停止序列帧动画
                    if (enemy.type == kEnemyBig) {
                        [enemyView stopAnimating];
                    }
                    enemyView.image = enemyView.hitImage;
                }
            }
        }
    }
    
    //英雄和敌机的碰撞
    //遍历敌机集合，如果和英雄发生碰撞，英雄OVER,游戏结束
    for(EnemyView *enemyView in self.enemyViewSet){
        if (CGRectIntersectsRect(enemyView.frame, self.gameModel.hero.collisionFrame)) {
            //NSLog(@"hero over");
            [self.soundTool playSoundByFileName:@"game_over"];
            
            //英雄爆炸的镜头,因为英雄OVER，游戏就结束了，不再需要时钟方法，因此此处可以用序列帧实现
            //1）停止当前英雄的序列帧动画
            [self.heroView stopAnimating];
            
            //设置英雄爆炸后，最后的影像
            [self.heroView setImage:self.imagesRes.heroBlowupImages[3]];
            
            //2）更换英雄的序列帧图片
            [self.heroView setAnimationImages:self.imagesRes.heroBlowupImages];
            
            //3）设置序列帧时长
            [self.heroView setAnimationDuration:1.0f];
            
            //设置动画重复次数
            [self.heroView setAnimationRepeatCount:1];
            
            //4）启动序列帧动画
            [self.heroView startAnimating];
            
            //5）播放一次后，关闭时钟
            [self performSelector:@selector(stopGameTimer) withObject:nil afterDelay:1.0f];
            
            [self.soundTool stopMusic];
            
            //直接跳出循环，不再继续遍历
            break;
            
        }
    }
    
}

//开始游戏时钟
-(void)startGameTimer
{
    //实例化游戏时钟
    //1.实例化
    self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    
    [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

//停止游戏时钟
-(void)stopGameTimer
{
    //通过时钟来处理界面的变化，如果把时钟停止，游戏将停止
    [self.gameTimer invalidate];
}

-(void)updateEnemys
{
    //NSLog(@"enemy count %ld", self.enemyViewSet.count);
    
    //每一帧按照集合中（遍历）飞机的速度（speed）下降
    //问题：英雄太容易牺牲了
    for(EnemyView *enemyView in self.enemyViewSet){
        Enemy *enemy = enemyView.enemy;
        
        //1)更新位置position属性
        enemy.position = CGPointMake(enemy.position.x, enemy.position.y + enemy.speed);
        
        //2)根据position属性，调整敌机位置
        [enemyView setCenter:enemy.position];
    }
    
    //遍历集合，如果飞机移除屏幕，需要从集合和视图中删除
    //与子弹类似，遍历集合时不能直接删除
    NSMutableSet *toRemovedSet = [NSMutableSet set];
    
    for(EnemyView *enemyView in self.enemyViewSet){
        
        if (enemyView.frame.origin.y >= self.gameModel.gameAera.size.height) {
            //需要删除
            [toRemovedSet addObject:enemyView];
        }
    }
    
    //遍历要删除的集合，清楚内容
    for(EnemyView *enemyView in toRemovedSet){
        [self.enemyViewSet removeObject:enemyView];
        [enemyView removeFromSuperview];
    }
    
    //清空临时集合
    [toRemovedSet removeAllObjects];
}

-(void)checkBullets
{
    //NSLog(@"bullet count %ld", self.bulletViewSet.count);
    //因为此方法调用频繁，不适合使用懒加载方式
//    if (self.bulletViewSet == nil) {
//        self.bulletViewSet = [NSMutableSet set];
//    }
    
    //如果需要删除集合中的数据，需要使用一个缓冲集合
    NSMutableSet *toRemovedSet = [NSMutableSet set];
    
    //子弹每次向上移动5个点
    for(BulletView *bulletView in self.bulletViewSet){
        //计算子弹新位置，向上移动的数值越大，对英雄越不利
        CGPoint position = CGPointMake(bulletView.center.x, bulletView.center.y - 5.0);
        
        //移动子弹视图
        [bulletView setCenter:position];
        
        //判断子弹是否飞出屏幕
        if(CGRectGetMaxY(bulletView.frame) < 0){
            [toRemovedSet addObject:bulletView];
            
        }
    }
    
    //遍历要删除的集合，清除飞出屏幕的子弹
    for(BulletView *bulletView in toRemovedSet){
        //从视图中删除
        [bulletView removeFromSuperview];
        
        //从集合中删除
        [self.bulletViewSet removeObject:bulletView];

    }
    
    //清空缓存
    [toRemovedSet removeAllObjects];
    
    //根据model.hero中新增加的子弹数量，并添加子弹视图
    for(Bullet *bullet in self.gameModel.hero.bulletSet){
        //新建子弹视图
        UIImage *image = self.imagesRes.bulletNormalImage;
        
        if (bullet.isEnhanced) {
            image = self.imagesRes.bulletEnhancedImage;
        }
        
        //新建子弹视图
        BulletView *bulletView = [[BulletView alloc]initWithImage:image bullet:bullet];
        
        //设置子弹中心
        [bulletView setCenter:bullet.position];
        
        //将子弹添加到视图
        [self.gameView addSubview:bulletView];
        
        //将子弹添加到子弹视图集合中
        [self.bulletViewSet addObject:bulletView];
    }
    
    //清空英雄中的子弹集合
    [self.gameModel.hero.bulletSet removeAllObjects];

}

#pragma mark - 成员方法
#pragma mark 加载资源
-(void)loadResources
{
    //加载图像缓存
    self.imagesRes = [[ImageResources alloc]init];
    //加载音乐及音效文件
    self.soundTool = [[SoundTool alloc]init];
}

@end

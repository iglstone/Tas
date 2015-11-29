//
//  ViewController.m
//  Tas
//
//  Created by 郭龙 on 15/11/28.
//  Copyright © 2015年 郭龙. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import "RecicleView.h"

#define WIDTH_OF_SCROLL_PAGE 320
#define HEIGHT_OF_SCROLL_PAGE 460
#define WIDTH_OF_IMAGE 320
#define HEIGHT_OF_IMAGE 284
#define LEFT_EDGE_OFSET 0

@interface ViewController () <JingRoundViewDelegate,AVAudioPlayerDelegate,UIScrollViewDelegate>{
    AVAudioPlayer *avAudioPlayer;
    NSInteger times;
    BOOL isplay;
    JingRoundView *roundView;
}

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    times = 0;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    NSInteger screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    RecicleView *home = [[RecicleView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, 260)];
    [self.view addSubview:home];
    
    roundView = [[JingRoundView alloc] init];
    roundView.delegate = self;
    roundView.roundImage = [UIImage imageNamed:@"girl"];
    roundView.rotationDuration = 10.0;
    roundView.isPlay = YES;
    isplay = YES;
    [self.view addSubview:roundView];
    [roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    //从budle路径下读取音频文件　　轻音乐 - 萨克斯回家 这个文件名是你的歌曲名字,mp3是你的音频格式
    NSString *string = [[NSBundle mainBundle] pathForResource:@"夏洛特烦恼" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    avAudioPlayer.delegate = self;
    //设置初始音量大小
    // avAudioPlayer.volume = 1;
    //设置音乐播放次数  -1为一直循环
    avAudioPlayer.numberOfLoops = -1;
     //预播放
    [avAudioPlayer prepareToPlay];
    [avAudioPlayer play];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
//    [timer fire];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runAgain) name:@"yes" object:nil];
}

- (void)runAgain {
    if (isplay) {
//        [self playStatuUpdate:YES];
//        [self.roundView pause];
//        [roundView play];
    }
//    else
//        [roundView pause];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    
//}

- (void)action {
    NSLog(@"repeat..");
    times ++;
    if (times == 3) {
        times = 0;
        return;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playStatuUpdate:(BOOL)playState
{
    if (playState) {
        [avAudioPlayer play];
//        [roundView play];
        isplay = YES;
    }
    else{
        [avAudioPlayer pause];
        isplay = NO;
//        [roundView pause];
    }

    NSLog(@"%@...", playState ? @"播放": @"暂停了");
}

@end

//
//  ViewController.m
//  VidioGoo
//
//  Created by admin on 16/8/11.
//  Copyright © 2016年 SupingLi. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <YKPlayerSDK/YKPlayerSDK.h>
#import "video.h"
#import "WebViewViewController.h"


// youku url
#define KYKPlayerUrl @"http://player.youku.com/embed/XMTY4MzQ2OTQ1Mg=="
// html
#define KHTUrl @"<embed src='http://player.youku.com/player.php/sid/XMTY2MjM5NzE0MA==/v.swf' allowFullScreen="true" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>"
// univer
#define KMANYUUrl @"<iframe height=498 width=510 src='http://player.youku.com/embed/XMTY2MjM5NzE0MA==' frameborder=0 allowfullscreen></iframe>"
#define KBeautyUrl @"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
//bilibili
#define KBiliUrl @"http://www.bilibili.com/video/av5726190/?tg"
#define enene @"http://www.bilibilijj.com/Api/AvToCid/5726190/0"

// youku app key
#define KYKAPPKEY @"0b4495df1a2bb385"
#define KYKAPPSECRET @"44ec45a93ecf4c4f169685cb1b5a0a72"

#define KBLPlayerUrl2 @"http://www.bilibilijj.com/Api/AvToCid/79933/0"

@interface ViewController ()<YKPlayerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *vidioUrl;
@property (strong, nonatomic) AVPlayer * player;
@property (strong, nonatomic) YKPlayerManager * YKManager;
@property (weak, nonatomic) IBOutlet UIButton *webViewBtn;
@property (strong, nonatomic) NSString * totleTime;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullBtn;

@property (nonatomic, strong) AVPlayerItem * item;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 播放声音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //1. AVPlayer
    [self configPlayer];
    
    // 2. youku
//    UIView * playView = [self.YKManager playerView];
//    playView.frame = CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 200);
//    [self.view addSubview:playView];
    
//     has authority
//    [self.YKManager initAppKey:KYKAPPKEY andAppSecret:KYKAPPSECRET];
//    [self.YKManager checkAuthorityForPlay:^(BOOL success) {
//        NSLog(@"isscussess : %d",success);
//        if (success) {
//            // has authority
//            [self.YKManager setYKPlayerDelegate:self];
//            // id
//            [self.YKManager getVideoFromCloudWithVideoId:@"XMTY2MjM5NzE0MA" completionHandler:^(YKPlayerVideo *video) {
//                if (video) {
////                    NSSet * array = [video allSupportQuality];
//                    [self.YKManager playVideoWithQuality:YKPlayerVideoHD];
//                }
//            }];
//            
//        }
//    }];
    
    //2.1 youku OK
    //3. bilibili half OK 
    
    //http://bangumi.bilibili.com/anime/v/91034
    //http://www.bilibili.com/video/av5397654/
    //http://bangumi.bilibili.com/anime/v/90914
    //http://www.bilibili.com/topic/1433.html
    //http://www.bilibili.com/video/av5804643/?from=yl
    //http://www.bilibili.com/video/av5771542/
    //<embed height="415" width="544" quality="high" allowfullscreen="true" type="application/x-shockwave-flash" src="http://static.hdslb.com/miniloader.swf" flashvars="aid=5795398&page=1" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"></embed>
    //http://www.bilibili.com/video/av5795398/

//    [[LKAPIClient sharedClient] requestPOSTForGetUserInfo:@"5795398/0" params:nil modelClass:[video class] completionHandler:^(LKJSonModel *aModelBaseObject) {
//        video * urlVideo;
//        
//        if ([aModelBaseObject isKindOfClass:[video class]]) {
//            urlVideo = (video *)aModelBaseObject;
//        }
//        NSString * url = urlVideo.list[0][@"Mp4Url"];
//        NSLog(@"before.url:-------%@",url);
//        if (![url isKindOfClass:[NSNull class]] && url.length > 0) {
//            WebViewViewController * v = [[WebViewViewController alloc] initWithNibName:nil bundle:nil];
//            v.url = url;
//            [self presentViewController:v animated:YES completion:nil];
//        } else {
//            NSLog(@"no url");
//            NSLog(@"%@",urlVideo.list);
//        }
//        
//        
//    } errorHandler:^(LKAPIError *engineError) {
//        
//    }];
 
}

- (void)configPlayer {
    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.backView.frame.size.height);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.backView.layer addSublayer:layer];
    [self.backView bringSubviewToFront:self.progressView];
    [self.backView bringSubviewToFront:self.startBtn];
    [self.startBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.startBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self addProgressObserver];
    [self.player play];
    self.player.usesExternalPlaybackWhileExternalScreenIsActive = YES;
    self.player.allowsExternalPlayback = YES;
    self.startBtn.selected = YES;
}

// 进度更新
- (void)addProgressObserver {
    [self.progressView setProgress:0 animated:YES];
    AVPlayerItem * item = [self.player currentItem];
    UIProgressView * progress = self.progressView;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat current = CMTimeGetSeconds(time);
        CGFloat totel = CMTimeGetSeconds([item duration]);
        NSLog(@"当前已播放：%.2fs",current);
        if (current) {
            [progress setProgress:(current/totel) animated:YES];
        }
    }];
}
//监控item
- (void)addObserverToItem:(AVPlayerItem *)item {
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

// 监控播放器状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem * item = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"正在播放，长度：%.2f",CMTimeGetSeconds(item.duration));
        } else if([keyPath isEqualToString:@"loadedtimeRanges"]) {
            NSArray * array = item.loadedTimeRanges;
            CMTimeRange timeTange = [array.firstObject CMTimeRangeValue];
            float start = CMTimeGetSeconds(timeTange.start);
            float duration = CMTimeGetSeconds(timeTange.duration);
            NSTimeInterval totalBuffer = start + duration;
            NSLog(@"缓存:%.2f",totalBuffer);
        }
    }
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

#pragma mark - action

- (IBAction)fullScreenAction:(id)sender {
    
}


- (IBAction)startPlayBtn:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (self.player.rate == 0) {
        [self.player play];
        btn.selected = YES;
    } else if (self.player.rate == 1) {
        [self.player pause];
        btn.selected = NO;
    }
}

- (IBAction)webViewAction:(id)sender {
    WebViewViewController * v = [[WebViewViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:v animated:YES completion:nil];
}

#pragma mark - delegate

- (void)ykPlayerPrepareDone {
    
}
- (void)ykPlayerStopWithErrorCode:(NSUInteger)code extraInfo:(NSArray *)extraInfo {
    
}


- (void)ykPlayerUpdateNetworkSpeed:(NSInteger)speed {
    
}
- (void)ykPlayerUpdateVideoLoadedTime:(NSTimeInterval)time {
    
}

- (void)ykPlayerUpdateVideoCurrentTime:(NSTimeInterval)time {
    
}

- (void)ykPlayerUpdateAdCutdownTime:(NSTimeInterval)time {
    
}

- (void)ykPlayerBeginLoading {
    
}
- (void)ykPlayerEndLoading {
    
}

- (void)ykPlayerSeekDone {
    
}

- (void)ykPlayerPassiveSeekBegin {
    
}

- (void)ykPlayerPassiveSeekEnd {
    
}

- (void)ykPlayerWillSwitchToQuality:(NSUInteger)quality {
    
}
- (void)ykPlayerDidSwitchToQuality:(NSUInteger)quality {
    
}
- (void)ykPlayerFailSwitchToQuality:(NSUInteger)quality {
    
}

- (void)ykPlayerWillSwitchToScheme:(NSUInteger)scheme {
    
}
- (void)ykPlayerDidSwitchToScheme:(NSUInteger)scheme {
    
}

// Index start from 0
- (void)ykPlayerStartPlayVideoAtIndex:(NSInteger)index {
    
}
- (void)ykPlayerFinishPlayVideoAtIndex:(NSInteger)index {
    
}

- (void)ykPlayerStartVideoClip:(NSString *)cdnip index:(NSString *)index {
    
}
- (void)ykPlayerAdConnectDelay:(NSInteger)delay {
    
}
- (void)ykPlayerVideoConnectDelay:(NSInteger)delay {
    
}
- (void)ykPlayerAdHttp302Delay:(NSInteger)delay {
    
}
- (void)ykPlayerVideoHttp302Delay:(NSInteger)delay {
    
}

- (void)ykPlayerBeginPause {
    
}
- (void)ykPlayerEndPause {
    
}

#pragma mark - getter

- (YKPlayerManager *)YKManager {
    if (!_YKManager) {
        _YKManager = [YKPlayerManager sharedManager];
    }
    return _YKManager;
}

- (AVPlayer *)player {
    if (!_player) {
        _player = ({
            self.item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:KBeautyUrl]];
            AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem:self.item];
            player;
        });
    }
    return _player;
}

@end

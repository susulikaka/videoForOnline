//
//  YKPlayerManager.h
//  YKPlayerSDK
//
//  Created by SMY on 16/6/28.
//  Copyright © 2016年 SMY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "YKPlayerVideo.h"
#import "YKPlayerDelegate.h"

@interface YKPlayerManager : NSObject

+ (instancetype)sharedManager;

- (void)initAppKey:(NSString *)appKey andAppSecret:(NSString *)appSecret;
- (BOOL)checkAppKeyAndAppSecret;
- (void)checkAuthorityForPlay:(void (^)(BOOL success))completionHandler;
- (BOOL)hadAuth;
//- (void)getVideoFromYoukuWithVideoId:(NSString *)vid quality:(YKPlayerVideoQuality)quality completionHandler:(void (^)(YKPlayerVideo *video))completionHandler;
- (void)getVideoFromCloudWithVideoId:(NSString *)vid completionHandler:(void (^)(YKPlayerVideo *video))completionHandler;

@end

@interface YKPlayerManager (UIView)

@property (nonatomic, assign, readonly) UIView *playerView;
@property (nonatomic, assign, readonly) CGRect playerViewRect;
@property (nonatomic, assign, readonly) AVPlayerLayer *playerLayer;
//@property (nonatomic) YTCorePlayerViewGravity gravity;
@property (nonatomic) float scale;

@end

@interface YKPlayerManager (PlayVideoControl)

@property (nonatomic) YKPlayerVideoQuality quality;      // Can not be KVO
@property (nonatomic) BOOL enableSkip;                  // 允许跳过片头片尾

- (BOOL)playVideoWithQuality:(YKPlayerVideoQuality)quality;
- (BOOL)playVideoWithUrl:(NSString *)url;
- (BOOL)playLocalVideoWithUrl:(NSString *)url; 

@end

@interface YKPlayerManager (PlayControl)

- (void)play;
- (void)pause;
- (void)stop;
- (void)stopAndKeepingLastFrame;
- (void)releasePlayer;
- (BOOL)isPlaying;
- (BOOL)isSeeking;
- (BOOL)isPausing;
- (BOOL)isLoading;
- (BOOL)isAudioPlayerMode;
- (BOOL)isQualityChanging;
- (BOOL)isStereoPlayingAudioMode;

@end

@interface YKPlayerManager (TimeControl)

- (NSTimeInterval)duration;
- (NSTimeInterval)currentTime;
- (NSTimeInterval)loadedTime;
- (NSTimeInterval)tailDuration;
- (NSTimeInterval)startTime;
- (void)seekToTime:(NSTimeInterval)time;
- (void)setEnableLoadData:(BOOL)enable;

@end

@interface YKPlayerManager (BackgroundAudio)

@property (nonatomic, assign) BOOL enableBackgroundAudioMode;

- (id)currentAudioPlayer;

- (void)pauseAudioPlayer;

- (void)continuePlayAudioPlayer;

@end

@interface YKPlayerManager (SmoothChangeQuality)

- (void)beginSmoothDownQuality:(YKPlayerVideoQuality)quality;
- (void)endSmoothDownQuality:(YKPlayerVideoQuality)quality;
- (void)cancelSmoothChangeQuality:(YKPlayerVideoQuality)quality;
@end

@interface YKPlayerManager (StereoAudio)

@property (nonatomic, assign) BOOL enableStereoAudio;

@end

@interface YKPlayerManager (Delegate)

- (void)setYKPlayerDelegate:(id<YKPlayerDelegate>)delegate;

@end

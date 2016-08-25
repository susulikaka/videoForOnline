//
//  YKPlayerDelegate.h
//  YKPlayerSDK
//
//  Created by SMY on 16/7/10.
//  Copyright © 2016年 SMY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YKPlayerDelegate <NSObject>

@required
- (void)ykPlayerPrepareDone;
- (void)ykPlayerStopWithErrorCode:(NSUInteger)code extraInfo:(NSArray *)extraInfo;


- (void)ykPlayerUpdateNetworkSpeed:(NSInteger)speed;
- (void)ykPlayerUpdateVideoLoadedTime:(NSTimeInterval)time;
- (void)ykPlayerUpdateVideoCurrentTime:(NSTimeInterval)time;
- (void)ykPlayerUpdateAdCutdownTime:(NSTimeInterval)time;

- (void)ykPlayerBeginLoading;
- (void)ykPlayerEndLoading;

- (void)ykPlayerSeekDone;

- (void)ykPlayerPassiveSeekBegin;

- (void)ykPlayerPassiveSeekEnd;

- (void)ykPlayerWillSwitchToQuality:(NSUInteger)quality;
- (void)ykPlayerDidSwitchToQuality:(NSUInteger)quality;
- (void)ykPlayerFailSwitchToQuality:(NSUInteger)quality;

- (void)ykPlayerWillSwitchToScheme:(NSUInteger)scheme;
- (void)ykPlayerDidSwitchToScheme:(NSUInteger)scheme;

// Index start from 0
- (void)ykPlayerStartPlayVideoAtIndex:(NSInteger)index;
- (void)ykPlayerFinishPlayVideoAtIndex:(NSInteger)index;

- (void)ykPlayerStartVideoClip:(NSString *)cdnip index:(NSString *)index;
- (void)ykPlayerAdConnectDelay:(NSInteger)delay;
- (void)ykPlayerVideoConnectDelay:(NSInteger)delay;
- (void)ykPlayerAdHttp302Delay:(NSInteger)delay;
- (void)ykPlayerVideoHttp302Delay:(NSInteger)delay;

- (void)ykPlayerBeginPause;
- (void)ykPlayerEndPause;

@end

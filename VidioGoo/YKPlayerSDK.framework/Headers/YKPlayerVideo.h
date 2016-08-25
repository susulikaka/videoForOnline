//
//  YKPlayerVideo.h
//  YKPlayerSDK
//
//  Created by SMY on 16/7/6.
//  Copyright © 2016年 SMY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YKPlayerVideoQuality)
{
    YKPlayerVideoSD = 0,      // 标清
    YKPlayerVideoHD,          // 高清
    YKPlayerVideoHD2,         // 超清
    YKPlayerVideoHD3          // 超高清
};

@interface YKPlayerVideo : NSObject {
    
}

@property (nonatomic, strong) NSString *videoId;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) double duration; //秒

@property (nonatomic, strong) NSString *posterUrl;

- (NSSet *)allSupportQuality;

@end

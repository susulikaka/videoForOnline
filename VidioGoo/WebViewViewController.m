//
//  WebViewViewController.m
//  VidioGoo
//
//  Created by admin on 16/8/15.
//  Copyright © 2016年 SupingLi. All rights reserved.
//

#import "WebViewViewController.h"


// youku
//    <iframe height=498 width=510 src="http://player.youku.com/embed/XMTUwMjUzMTY0NA==" frameborder=0 allowfullscreen></iframe>
#define new @"<iframe height=498 width=510 src='http://player.youku.com/embed/XNTc4MTM5Mzk2' frameborder=0 allowfullscreen></iframe>"
#define new2 @"<iframe height=498 width=510 src='http://player.youku.com/embed/XMTY3NzgzNjYxNg==' frameborder=0 allowfullscreen></iframe>"

#define KYKPlayerUrl @"http://player.youku.com/emb/ed/XMTY4MzQ2OTQ1Mg=="
// youku 固定URL： @"http://player.youku.com/embed/?YOUKU_ID=="
#define KYKPlayerUrl2 @"http://player.youku.com/embed/XMTUwMjUzMTY0NA=="
// bilibili 固定URL: @"http://www.bilibilijj.com/Api/AvToCid/?BILIBILI_ID/0"
#define KBLUrl @"http://www.bilibilijj.com/Files/DownLoad/"
#define endUrl @".mp4/www.bilibilijj.com.mp4?mp3=true"

//http://www.bilibili.com/video/av5684886/


@interface WebViewViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.webView setScalesPageToFit:YES];
    [self.webView setOpaque:NO];// alpha = 1
    // bilibili
    NSString * strs = [NSString stringWithFormat:@"%@%d%@",KBLUrl,5771542,endUrl];
    NSLog(@"strs----------------%@",strs);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // youku
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:new]]];
    
    NSMutableString * str = [[NSMutableString alloc] init];
    [str appendString:@"<html>"];
    [str appendString:@"<title style = 'text-align:center;'>"];
    [str appendString:@"视频播放"];
    [str appendString:@"</title>"];
    [str appendString:@"<style>body {position: relative;}iframe {position: absolute;top: 0;bottom: 0;left: 0;right: 0;width: 100%;margin: auto;}</style>"];
    [str appendString:@"<body>"];
    [str appendString:new2];
    [str appendString:@"</div>"];
    [str appendString:@"</body>"];
    
    [str appendString:@"</html>"];
//    [self.webView loadHTMLString:str baseURL:nil];
    
    // html5
    //部分设备可以先调用video.pause()，然后再调用video.play()接口可以实现自动播放
//    self.webView.allowsInlineMediaPlayback = YES;
//    self.webView.mediaPlaybackRequiresUserAction = NO;
    if (self.url == nil) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.querySelector('video').start();"];
        
    }
    
    
    
}

#pragma mark - getter

@end

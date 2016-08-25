# videoForOnline
// sound
[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
// 1.
youku 固定URL： @"http://player.youku.com/embed/?YOUKU_ID==" // web request can use webview
you 收藏:<iframe height=498 width=510 src='http://player.youku.com/embed/XMTY3NzgzNjYxNg==' frameborder=0 allowfullscreen></iframe> // 用html包裹就可以播放：stringByEvaluatingJavaScriptFromString了
bilibili 部分固定URL: @"http://www.bilibilijj.com/Api/AvToCid/?BILIBILI_out_ID/0" // web request and then get a mp4 list.

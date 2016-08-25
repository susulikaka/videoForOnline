//
//  video.h
//  VidioGoo
//
//  Created by admin on 16/8/15.
//  Copyright © 2016年 SupingLi. All rights reserved.
//

#import "LKJSonModel.h"

@interface video : LKJSonModel

@property (nonatomic, strong)NSString * title;
@property (nonatomic, strong)NSString * desc;
@property (nonatomic, strong)NSString * img;
@property (nonatomic, strong)NSArray * list;//Mp4Url
@end

//
//  使用方法：
//  KDShareTool *shareTool = [[KDShareTool alloc] init];
//  //图片传nil,默认是口袋广播图片，否则传图片（放数组中）
//  [shareTool shareMethodTitle:self.model.title content:self.model.intro url:self.url images:nil];
//
//  Created by 韩军强 on 16/10/9.
//  Copyright © 2016年 CSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWShareView.h"
#import <ShareSDK/ShareSDK.h>
#import<MessageUI/MessageUI.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface KDShareTool : NSObject

@property (nonatomic, strong) NSMutableDictionary *messageParam;
@property (nonatomic, strong) JWShareView *shareView;

/**
 *  注：  QQ空间必须要传图片，否则分享失败。
 *       QQ、微信、朋友圈不传图片分享的只是文本,所以也要传图片。
 *       新浪微博可以不传图片，但是文本后面要拼接URL，这样微博里就可以自动生成一个URL。
 *  @param ktitle   标题
 *  @param kcontent 内容
 *  @param kurl     该文章的URL
 *  @param kImages  数组形式
 */
-(void)shareMethodTitle:(NSString *)ktitle content:(NSString *)kcontent url:(NSURL *)kurl images:(NSMutableArray *)kImages;

@end

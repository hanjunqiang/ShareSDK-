//
//  KDShareTool.m
//  自定义Tabbar
//
//  Created by 韩军强 on 16/10/9.
//  Copyright © 2016年 CSC. All rights reserved.
//

#import "KDShareTool.h"
#import "KDAlertView.h"

@implementation KDShareTool


-(void)shareMethodTitle:(NSString *)ktitle content:(NSString *)kcontent url:(NSURL *)kurl images:(NSMutableArray *)kImages
{

    NSMutableArray *contentArray = [NSMutableArray array];
    //注意这里的title、img是和下面自定义控件JWShareView的参数对应的。
    NSArray *wechat = @[
                        @{@"title": @"朋友圈", @"img": @"ShareSDKUI.bundle/Icon/sns_icon_23"},
                        @{@"title": @"微信", @"img": @"ShareSDKUI.bundle/Icon/sns_icon_22"}
                        ];
    NSArray *qq = @[
                    @{@"title": @"QQ", @"img": @"ShareSDKUI.bundle/Icon/sns_icon_24"},
                    @{@"title": @"QQ空间", @"img": @"ShareSDKUI.bundle/Icon/sns_icon_6"}
                    ];
    
    NSArray *weibo = @[
                       @{@"title": @"新浪微博", @"img": @"ShareSDKUI.bundle/Icon/sns_icon_1"}
                       ];
    
    //检查微信是否已被用户安装
    if ([WXApi isWXAppInstalled]) {
        [contentArray addObjectsFromArray:wechat];
    }
    
    if ([TencentOAuth iphoneQQInstalled]) {
        [contentArray addObjectsFromArray:qq];
    }
    
    // 始终显示新浪微博
    [contentArray addObjectsFromArray:weibo];
    JWShareView *shareView = [[JWShareView alloc] init];
    self.shareView = shareView;
    [shareView addShareItems:[UIApplication sharedApplication].keyWindow shareItems:contentArray selectShareItem:^(NSInteger tag, NSString *title) {
       
        
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        //分享除了新浪微博都要传图片。
        UIImage *morenImage ;
        if (!kImages) {
            morenImage = [UIImage imageNamed:@"logo_03"];
        }
        
        NSString *kcontent2 = kcontent.isNotNullStr?kcontent:@"";
        NSString *ktitle2 = ktitle.isNotNullStr?ktitle:@"";
        
        [shareParams SSDKSetupShareParamsByText:kcontent2
                                         images:kImages.isNotNullStr?kImages:morenImage
                                            url:kurl
                                          title:ktitle2
                                           type:SSDKContentTypeAuto];
        
        self.messageParam = shareParams;


        
        if ([title isEqualToString:@"QQ"]) {
            
            [self shareWithType:SSDKPlatformSubTypeQQFriend];
            
        }else if ([title isEqualToString:@"QQ空间"])
        {
            //QQ空间必须要传图片
            [self shareWithType:SSDKPlatformSubTypeQZone];
            
        }else if ([title isEqualToString:@"微信"])
        {
            [self shareWithType:SSDKPlatformSubTypeWechatSession];
            
        }else if ([title isEqualToString:@"朋友圈"])
        {
            [self shareWithType:SSDKPlatformSubTypeWechatTimeline];
            
        }else if ([title isEqualToString:@"新浪微博"])
        {
            if (kurl.isNotNullStr) {
                // 新浪分享文本是 文本和url 拼接(默认会有个链接标识)
                NSString *text = [NSString stringWithFormat:@"%@\n%@", ktitle2,kurl];
                [self.messageParam setObject:text forKey:@"text"];
            }
            if (!kImages) {
                [self.messageParam setObject:@"" forKey:@"images"];
            }
            [self shareWithType:SSDKPlatformTypeSinaWeibo];
            
        }
        
    }];

    
}

- (void)shareWithType:(SSDKPlatformType)type
{
    [self.shareView cancleButtonAction];
    //进行分享
    [ShareSDK share:type
         parameters:self.messageParam
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         KDLOG(@"%@", error);

         //         self.superVC = nil;
         
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 
//                 NSLog(@"msgParam==%@",self.messageParam);
//                [KDAlertView showMessage:@"分享成功！" title:@"" cancelBtnTitle:@"确定" buttonBlock:^(NSInteger buttonIndex) {
//                     
//                 }];
                 [MBProgressHUD showSuccess:@"分享成功！"];

                 break;
             }
             case SSDKResponseStateFail:
             {
                 
//                 [KDAlertView showMessage:@"分享失败！" title:@"" cancelBtnTitle:@"确定" buttonBlock:^(NSInteger buttonIndex) {
//                     
//                 }];
                 [MBProgressHUD showSuccess:@"分享失败！"];

                 break;
             }
             case SSDKResponseStateCancel:
             {
                 //分享成功，选择留在QQ时，回来这里，所以去掉他
//                 [KDAlertView showMessage:@"分享取消！" title:@"" cancelBtnTitle:@"确定" buttonBlock:^(NSInteger buttonIndex) {
//                     
//                 }];
//                 [MBProgressHUD showSuccess:@"分享取消！"];

                 break;
             }
             default:
                 break;
         }
     }];
}


@end
